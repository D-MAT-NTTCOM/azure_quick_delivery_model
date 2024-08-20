# WinでAzureにTerraformするメモ

## やること

1. 検証用Windows端末から
2. Githubにあるコードを使って
3. Azureリソースをデプロイする

## 前提

### WSL2でUbuntuが動いてること

```console
[d-mat@SurfaceLaptop7 ~]$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.4 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.4 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### （最新版の）Terraformインストール済み

```console
[d-mat@SurfaceLaptop7 ~]$ tfenv use latest
Switching default version to v1.9.4
Default version (when not overridden by .terraform-version or TFENV_TERRAFORM_VERSION) is now: 1.9.4
[d-mat@SurfaceLaptop7 ~]$ terraform -v
Terraform v1.9.4
on linux_arm64
```

## ディレクトリ構成

```console:local
[d-mat@SurfaceLaptop7 ~/terraform]$ tree
.
└── dev01
    ├── main.tf
    ├── param.tfvars
    ├── terraform.tfstate
    └── variables.tf

1 directory, 4 files
```