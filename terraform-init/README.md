<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_state_storage"></a> [state\_storage](#module\_state\_storage) | ./modules/state-storage | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix of the resource name. | `string` | `"wp10"` | no |
| <a name="input_state_env_tag"></a> [state\_env\_tag](#input\_state\_env\_tag) | Environment tag applied to all created resources. | `string` | `"dev"` | no |
| <a name="input_state_project_tag"></a> [state\_project\_tag](#input\_state\_project\_tag) | Project tag applied to all created resources. | `string` | `"wp10"` | no |
| <a name="input_state_rg_location"></a> [state\_rg\_location](#input\_state\_rg\_location) | Location of the resource group. | `string` | `"westeurope"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_state_container_name"></a> [state\_container\_name](#output\_state\_container\_name) | n/a |
| <a name="output_state_storage_account_name"></a> [state\_storage\_account\_name](#output\_state\_storage\_account\_name) | n/a |
<!-- END_TF_DOCS -->