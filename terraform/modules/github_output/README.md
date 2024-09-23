<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_github"></a> [github](#provider\_github) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.jumphost_ip_gh_secret](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.runner_host_ip_gh_secret](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.ssh_key_gh_secret](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/actions_secret) | resource |
| [external_external.encrypt_jumphost_ip](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.encrypt_runner_host_ip](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.encrypt_ssh_key](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [github_actions_public_key.wp10](https://registry.terraform.io/providers/hashicorp/github/latest/docs/data-sources/actions_public_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_jumphost_ip"></a> [jumphost\_ip](#input\_jumphost\_ip) | Public IP address of the jumphost VM. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository in which to save output secrets. | `string` | `"wp10-image-factory"` | no |
| <a name="input_runner_host_ip"></a> [runner\_host\_ip](#input\_runner\_host\_ip) | Private IP address of the runner host VM. | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | Private SSH key created during VM deployment. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jumphost_ip_encrypted"></a> [jumphost\_ip\_encrypted](#output\_jumphost\_ip\_encrypted) | n/a |
| <a name="output_private_key_encrypted"></a> [private\_key\_encrypted](#output\_private\_key\_encrypted) | n/a |
| <a name="output_runner_host_ip_encrypted"></a> [runner\_host\_ip\_encrypted](#output\_runner\_host\_ip\_encrypted) | n/a |
<!-- END_TF_DOCS -->