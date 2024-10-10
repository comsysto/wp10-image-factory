<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.state_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix of the resource name. | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group. | `string` | n/a | yes |
| <a name="input_state_env_tag"></a> [state\_env\_tag](#input\_state\_env\_tag) | Environment tag applied to all created resources. | `string` | n/a | yes |
| <a name="input_state_project_tag"></a> [state\_project\_tag](#input\_state\_project\_tag) | Project tag applied to all created resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of the created resource group. Value needed for config.azurerm.tfbackend. |
| <a name="output_state_container_name"></a> [state\_container\_name](#output\_state\_container\_name) | Name of the storage account container used for the terraform state. Value needed for config.azurerm.tfbackend. |
| <a name="output_state_storage_account_name"></a> [state\_storage\_account\_name](#output\_state\_storage\_account\_name) | Name of the storage account used for terraform state backend. Value needed for config.azurerm.tfbackend. |
<!-- END_TF_DOCS -->