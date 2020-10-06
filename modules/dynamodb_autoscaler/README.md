# DynamoDB Autoscaler

Terraform module to provision DynamoDB autoscaler.

Autoscaler scales up/down the provisioned OPS for a DynamoDB table based on the load.

## Usage

```hcl
module "dynamodb_autoscaler" {
  source                       = "./module/dynamodb_autoscaler""
  namespace                    = "lic"
  stage                        = "dev"
  name                         = "cluster"
  dynamodb_table_name          = "lic-dev-cluster-table_name"
  dynamodb_indexes             = [ "first-index", "second-index" ]
  dynamodb_table_arn           = "arn:aws:dynamodb:ap-southeast-2:123456789012:table/lic-dev-cluster-table_name"
  autoscale_write_target       = 50
  autoscale_read_target        = 50
  autoscale_min_read_capacity  = 5
  autoscale_max_read_capacity  = 20
  autoscale_min_write_capacity = 5
  autoscale_max_write_capacity = 20
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes (e.g `policy` or `role`) | list | `<list>` | no |
| autoscale\_max\_read\_capacity | DynamoDB autoscaling max read capacity | string | `20` | no |
| autoscale\_max\_write\_capacity | DynamoDB autoscaling max write capacity | string | `20` | no |
| autoscale\_min\_read\_capacity | DynamoDB autoscaling min read capacity | string | `5` | no |
| autoscale\_min\_write\_capacity | DynamoDB autoscaling min write capacity | string | `5` | no |
| autoscale\_read\_target | The target value (in %) for DynamoDB read autoscaling | string | `50` | no |
| autoscale\_write\_target | The target value (in %) for DynamoDB write autoscaling | string | `50` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| dynamodb\_indexes | List of DynamoDB indexes | list | `<list>` | no |
| dynamodb\_table\_arn | DynamoDB table ARN | string | - | yes |
| dynamodb\_table\_name | DynamoDB table name | string | - | yes |
| enabled | Whether or not to create the modules resources | string | `true` | no |
| name | Name (e.g. `app` or `cluster`) | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`, `infra`) | string | - | yes |
| tags | Additional tags (e.g map(`BusinessUnit`,`XYX`) | map | `<map>` | no |
