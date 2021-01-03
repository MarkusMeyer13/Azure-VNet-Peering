# VNET Peering

## 1 Prerequisites

### 1.1 WSL 2 Ubuntu

[https://github.com/Azure/azure-functions-core-tools](https://github.com/Azure/azure-functions-core-tools)
[https://docs.microsoft.com/en-us/dotnet/core/install/linux](https://docs.microsoft.com/en-us/dotnet/core/install/linux)
[https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu)

[https://www.c-sharpcorner.com/article/hello-world-net-core-on-linux/](https://www.c-sharpcorner.com/article/hello-world-net-core-on-linux/)

sudo apt-get install jq

## 2 Configure settings

### 2.1 deploy-functions.sh

Specify values values for:
*app_cloud*
*app_on_premise*

### 2.2 deploy-vms.sh

Set *username* and *password*.

Specify values for Vnets:
*vnet_cloud_name*
*vnet_cloud_subnet_name*
*vnet_on_premise_name*
*vnet_on_premise_subnet_name*

### 2.3 deploy.sh

Specify values values for:
*resource_group*
*location*

## 3 Deployment

```bash
bash deploy.sh
```
