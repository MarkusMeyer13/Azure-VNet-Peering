#!/bin/bash
resource_group=$1
echo $resource_group

az deployment group create --resource-group $resource_group --template-file azuredeploy.json --parameters azuredeploy.parameters.json