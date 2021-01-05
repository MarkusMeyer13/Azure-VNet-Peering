#!/bin/bash
resource_group=$1
echo "resource_group: $resource_group"

echo "Get values"
apim_name=$(az apim list --resource-group $resource_group --query "[].name" --output tsv)
apim_name=$(echo "$apim_name" | tr -d '\r')
echo "apim_name:" $apim_name

echo 
# app_on_premise="func-on-premise"

app_on_premise=$(az functionapp list --resource-group $resource_group --query "[?contains(name, 'func-on-premise')].name" --output tsv)
app_on_premise=$(echo "$app_on_premise" | tr -d '\r')
echo "app_on_premise:" $app_on_premise

echo "$(tput setaf 2)Deploy App $app_on_premise $(tput setaf 7)"

echo "Create local.settings.json"
setting_function_onpremise="{ \"IsEncrypted\": false, \"Values\": { \"cloudAPIMUrl\": \"https://$apim_name.azure-api.net/private/evaluation/cloud\" }, \"ConnectionStrings\": {} }"
jq -n "$setting_function_onpremise" > "./Functions/PeeringFunctionOnPremise/local.settings.json"
cat ./Functions/PeeringFunctionOnPremise/local.settings.json

cd Functions
cd PeeringFunctionOnPremise
pwd

echo 
func azure functionapp fetch-app-settings $app_on_premise
func azure functionapp publish $app_on_premise --publish-local-settings -i

cd ..
cd ..
pwd


echo 
# app_cloud="func-cloud"

app_cloud=$(az functionapp list --resource-group $resource_group --query "[?contains(name, 'func-cloud')].name" --output tsv)
app_cloud=$(echo "$app_cloud" | tr -d '\r')
echo "app_cloud:" $app_cloud



echo "$(tput setaf 2)Deploy App $app_cloud $(tput setaf 7)"

echo "Create local.settings.json"
setting_function_cloud="{ \"IsEncrypted\": false, \"Values\": { \"onPremiseAPIMUrl\": \"https://$apim_name.azure-api.net/private/evaluation/onpremise\" }, \"ConnectionStrings\": {} }"
jq -n "$setting_function_cloud" > "./Functions/PeeringFunctionCloud/local.settings.json"
cat ./Functions/PeeringFunctionCloud/local.settings.json

cd Functions
cd PeeringFunctionCloud
pwd

echo 
func azure functionapp fetch-app-settings $app_cloud
func azure functionapp publish $app_cloud --publish-local-settings -i

cd ..
cd ..
pwd