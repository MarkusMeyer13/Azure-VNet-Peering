# VNET Peering

Please find more information here on [Dev.To](https://dev.to/markusmeyer13/azure-vnet-peering-29mm)

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

Deploy Azure resources, Function Apps and VMs:

```bash
bash deploy.sh
```
Deploy only Azure resources:

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMarkusMeyer13%2FAzure-VNet-Peering%2Fmaster%2Fazuredeploy.json)  [![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2raw.githubusercontent.com%2FMarkusMeyer13%2FAzure-VNet-Peering%2Fmaster%2Fazuredeploy.json)
