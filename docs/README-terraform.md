# Requirements
- Access to Azure Resource Manager
- `terraform >=1.0.0`, tested with `1.9.5`
- Azure CLI, tested with `2.64.0`
- Azure credentials saved as environment variables:
    ```
    export AZURE_CLIENT_ID=
    export AZURE_CLIENT_SECRET=
    export AZURE_TENANT_ID=
    export AZURE_SUBSCRIPTION_ID=
    ```

# Usage
Login to Azure and select subscription
```
az login --service-principal -u $AZURE_CLIENT_ID -p AZURE_CLIENT_SECRET --tenant AZURE_TENANT_ID
az account set --subscription AZURE_SUBSCRIPTION_ID
```

Setting up a Storage Account for the terraform state backend using terraform-init
```
# Change directory to 
cd terraform-init

terraform init
terraform plan
terraform apply
```
Mark down the output containing Azure Storage Account details and create `config.azurerm.tfbackend` from `config.azurerm.tfbackend.tempalte`

Deploying network and runner modules
```
# Change into main terraform directory 
cd terraform

# Source helper functions
source scripts/helpers.sh

# Retrieve Storage Account Access key
export RESOURCE_GROUP_NAME=$(extract_value "resource_group_name" config.azurerm.tfbackend)
export STORAGE_ACCOUNT_NAME=$(extract_value "storage_account_name" config.azurerm.tfbackend)
export ARM_ACCESS_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Decide on a terraform workspace
terraform workspace list
terraform workspace new # Create a terraform workspace, can be used for staging
terraform workspace select # Or select an existing workspace

# Initialize terraform with Azure Storage Account backend
terraform init --backend-config=config.azurerm.tfbackend 

# Plan, review and apply
terraform plan -out main.tfplan

terraform apply main.tfplan
```

The SSH key associated with the VM will be saved in the current working directory as `private_key.pem`