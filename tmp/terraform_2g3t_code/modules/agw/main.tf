#waf
resource "azurerm_web_application_firewall_policy" "waf" {
  location            = var.location
  name                = var.waf_name
  resource_group_name = var.resource_group_name
  
  policy_settings {
    max_request_body_size_in_kb      = 2000
    request_body_inspect_limit_in_kb = 2000
    file_upload_limit_in_mb = 100
    mode = "Prevention"
  }

  custom_rules {
    name = "DenyExceptClientIP"
    priority = "5"
    rule_type = "MatchRule"
    action = "Block"
    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }
      operator = "IPMatch"
      negation_condition = true
      match_values = var.allow_ip_waf
    }
  }

  managed_rules {
    managed_rule_set {
      type = "OWASP"
      version = "3.2"
      rule_group_override {
        rule_group_name = "REQUEST-913-SCANNER-DETECTION"
        rule {
          id = "913101"
          enabled = false
        }
      }
      rule_group_override {
        rule_group_name = "REQUEST-932-APPLICATION-ATTACK-RCE"
        rule {
          id = "932100"
          enabled = false
        }
        rule {
          id = "932130"
          enabled = false
        }
      }
      rule_group_override {
        rule_group_name = "REQUEST-941-APPLICATION-ATTACK-XSS"
        rule {
          id = "941320"
          enabled = false
        }
      }
      rule_group_override {
        rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
        rule {
          id = "942120"
          enabled = false
        }
        rule {
          id = "942130"
          enabled = false
        }
        rule {
          id = "942200"
          enabled = false
        }
        rule {
          id = "942260"
          enabled = false
        }
        rule {
          id = "942300"
          enabled = false
        }
        rule {
          id = "942330"
          enabled = false
        }
        rule {
          id = "942340"
          enabled = false
        }
        rule {
          id = "942370"
          enabled = false
        }
        rule {
          id = "942430"
          enabled = false
        }
        rule {
          id = "942440"
          enabled = false
        }
        rule {
          id = "942450"
          enabled = false
        }

      }
    }
  }
}




#agw
resource "azurerm_application_gateway" "agw" {
  enable_http2        = true
  firewall_policy_id  = var.waf_id
  location            = var.location
  name                = var.agw_name
  resource_group_name = var.resource_group_name
  zones               = ["1", "2", "3"]
  autoscale_configuration {
    max_capacity = 10
    min_capacity = 0
  }
  backend_address_pool {
    name = var.backend_pool_name
  }
  backend_http_settings {
    affinity_cookie_name  = var.affinity_name_443
    cookie_based_affinity = "Enabled"
    name                  = var.backend_name_443
    port                  = 443
    protocol              = "Https"
    request_timeout       = 20
  }
  backend_http_settings {
    affinity_cookie_name  = var.affinity_name_80
    cookie_based_affinity = "Enabled"
    name                  = var.backend_name_80
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIpIPv4"
    public_ip_address_id = var.pip_id_waf
  }
  frontend_port {
    name = "port_443"
    port = 443
  }
  frontend_port {
    name = "port_80"
    port = 80
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_id_agw
  }
  http_listener {
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_443"
    name                           = var.backend_lister_name_443
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name
  }
  http_listener {
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_80"
    name                           = var.backend_lister_name_80
    protocol                       = "Http"
  }
  request_routing_rule {
    backend_address_pool_name  = var.backend_pool_name
    backend_http_settings_name = var.backend_name_443
    http_listener_name         = var.backend_lister_name_443
    name                       = var.backend_route_name_443
    priority                   = 100
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = var.backend_pool_name
    backend_http_settings_name = var.backend_name_80
    http_listener_name         = var.backend_lister_name_80
    name                       = var.backend_route_name_80
    priority                   = 110
    rule_type                  = "Basic"
  }
  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }
  ssl_certificate {
    name = var.ssl_certificate_name
    #ssl certificate date from file
    data = filebase64(var.ssl_certificate_data)
    #ssl certificate password
    password = var.ssl_certificate_password
  }
  depends_on = [ azurerm_web_application_firewall_policy.waf ]
}

#バックエンドとの紐付け
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "backend_pool" {
  backend_address_pool_id = var.backend_address_pool_id
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = var.nic_web_id 
  depends_on = [ azurerm_application_gateway.agw ]
}