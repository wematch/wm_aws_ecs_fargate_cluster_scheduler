## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster_off"></a> [cluster\_off](#module\_cluster\_off) | terraform-aws-modules/lambda/aws | ~> 6.0 |
| <a name="module_cluster_on"></a> [cluster\_on](#module\_cluster\_on) | terraform-aws-modules/lambda/aws | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cluster_off](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.cluster_on](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.cluster_off](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.cluster_on](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_lambda_permission.cluster_off](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.cluster_on](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `any` | n/a | yes |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | n/a | `number` | `3` | no |
| <a name="input_ecs_cluster"></a> [ecs\_cluster](#input\_ecs\_cluster) | n/a | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_standard_tags"></a> [standard\_tags](#input\_standard\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_turn_off_schedule"></a> [turn\_off\_schedule](#input\_turn\_off\_schedule) | Turn OFF Schedule | `string` | `"cron(0 22 ? * SUN-FRI *)"` | no |
| <a name="input_turn_on_schedule"></a> [turn\_on\_schedule](#input\_turn\_on\_schedule) | Turn ON Schedule | `string` | `"cron(0 8 ? * SUN-FRI *)"` | no |

## Outputs

No outputs.
