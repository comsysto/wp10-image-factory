# terraform

Main terraform code for deploying an the Image Factory platform. For usage, refer to the [documentation](../docs/README-terraform.md)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~>1.15 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.4 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acg"></a> [acg](#module\_acg) | ./modules/acg | n/a |
| <a name="module_acr"></a> [acr](#module\_acr) | ./modules/acr | n/a |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_github_output"></a> [github\_output](#module\_github\_output) | ./modules/github_output | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_runner"></a> [runner](#module\_runner) | ./modules/runner | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_tag"></a> [env\_tag](#input\_env\_tag) | Environment tag applied to all created resources | `string` | `"dev"` | no |
| <a name="input_local_development"></a> [local\_development](#input\_local\_development) | Development purposes only: set to 'true' when running terraform apply locally. Outputs SSH private key to the terraform directory | `bool` | `false` | no |
| <a name="input_project_tag"></a> [project\_tag](#input\_project\_tag) | Project tag applied to all created resources | `string` | `"wp10"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository in which to save output secrets | `string` | `"wp10-image-factory"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group | `string` | `"westeurope"` | no |
| <a name="input_runner_image_id"></a> [runner\_image\_id](#input\_runner\_image\_id) | Shared Image Gallery ID of the runner VM image | `string` | `"/subscriptions/218f1214-da01-4678-8025-4e14a989e315/resourceGroups/wp10-tf-dev-rg/providers/Microsoft.Compute/galleries/wp10ImageFactoryGallery/images/image-factory-vm/versions/1.0.34"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of the created resource group. |
| <a name="output_runner_data"></a> [runner\_data](#output\_runner\_data) | Prints out runner data if `local_development` is set to `true`. |
<!-- END_TF_DOCS -->