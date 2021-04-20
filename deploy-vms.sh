#!/bin/bash
resource_group=$1
password="!pw123456pw!"
username="azureuser"

echo $resource_group

echo "Getting resource values"

echo
apim_private_ip=$(az apim list --resource-group $resource_group --query "[].privateIpAddresses" --output tsv)
apim_private_ip=$(echo "$apim_private_ip" | tr -d '\r')
echo "apim_private_ip:" $apim_private_ip

echo
apim_name=$(az apim list --resource-group $resource_group --query "[].name" --output tsv)
apim_name=$(echo "$apim_name" | tr -d '\r')
echo "apim_name:" $apim_name

echo
echo "Configure CloudInit >> /etc/hosts"
file=cloud-init.yml
cat cloud-init.txt > $file
echo "  - echo $apim_private_ip $apim_name.azure-api.net >> /etc/hosts" >> $file
echo "  - echo $apim_private_ip $apim_name.portal.azure-api.net >> /etc/hosts" >> $file
echo "  - echo $apim_private_ip $apim_name.developer.azure-api.net >> /etc/hosts" >> $file
echo "  - echo $apim_private_ip $apim_name.management.azure-api.net >> /etc/hosts" >> $file
echo "  - echo $apim_private_ip $apim_name.scm.azure-api.net >> /etc/hosts" >> $file

echo
cat $file


echo
echo "Create Linux Vms"
echo 

vnet_cloud_name="vnet-cloud"
vnet_cloud_subnet_name="snet-vnet-cloud-backends"

az vm create --resource-group $resource_group --name 'vm-cloud' --vnet-name $vnet_cloud_name --subnet $vnet_cloud_subnet_name --image UbuntuLTS --admin-username $username  --custom-data cloud-init.yml --admin-password $password


vnet_on_premise_name="vnet-on-premise"
vnet_on_premise_subnet_name="snet-vnet-on-premise-backends"

az vm create --resource-group $resource_group --name 'vm-on-premise' --vnet-name $vnet_on_premise_name --subnet $vnet_on_premise_subnet_name --image UbuntuLTS --admin-username $username  --custom-data cloud-init.yml --admin-password $password
