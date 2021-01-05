#!/bin/bash
resource_group="eval.peering"
location="westeurope"

function createAzureResources {
    group_exits=$(az group exists --name $resource_group --output tsv);
    group_exits=$(echo "$group_exits" | tr -d '\r')
    
    echo "Create Azure resources"
    if [ $group_exits = false ]; then
        echo "Group does not exists"
    else
        echo "Group exists and will be deleted first"
        az group delete --name $resource_group --yes
    fi
    
    az group create --name $resource_group --location $location
    sh ./deploy-azure-resources.sh $resource_group
}


createAzureResources


sh ./deploy-functions.sh $resource_group
sh ./deploy-vms.sh $resource_group

apim_name=$(az apim list --resource-group $resource_group --query "[].name" --output tsv)
apim_name=$(echo "$apim_name" | tr -d '\r')
echo "apim_name:" $apim_name

echo
echo "Connect to VMs and execute:"
echo

echo "curl https://$apim_name.azure-api.net/evaluation/onpremise"
echo "curl https://$apim_name.azure-api.net/evaluation/cloud"