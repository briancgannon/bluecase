## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| asg\_instance\_max\_count | Maximum number of EC2 instances in the AutoScale Group. | string | `"0"` | no |
| asg\_instance\_min\_count | Minimum number of EC2 instances in the AutoScale Group. | string | `"0"` | no |
| database\_allocated\_storage | Storage size for RDS instances. | string | `"250"` | no |
| database\_name | Database name. | string | `""` | no |
| database\_snapshot\_name | Database snapshot name. | string | `""` | no |
| env\_name | Environment name | string | `"sandbox"` | no |

