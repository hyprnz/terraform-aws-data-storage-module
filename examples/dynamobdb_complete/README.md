# Terraform DynamoDB Module Complete Terraform Example
A complete Terraform implementation using the Terraform DynamoDB module

The complete example has autoscaling enabled and adds additional
DynamoDB attributes, [local secondary
index](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LSI.html)
maps and [global secondary
index](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LSI.html)
maps.

## Configuration
The Terraform implmentation uses a Terraform
[local](https://www.terraform.io/docs/backends/types/local.html) backend which
stores state on the local filesystem.

Providers are configured in the `providers.tf` file, which sets approriate
versions to meet the module requirements.

The module configuration used in `main.tf`
```
module "dynamodb_table" {
  source                       = "git@github.com:lic-nz/terraform-dynamodb-module.git?ref=master"
  enabled                      = "true"
  dynamodb_enabled             = "true"
  namespace                    = "lic"
  stage                        = "dev"
  name                         = "cluster"
  hash_key                     = "HashKey"
  range_key                    = "RangeKey"
  autoscale_write_target       = 50
  autoscale_read_target        = 50
  autoscale_min_read_capacity  = 5
  autoscale_max_read_capacity  = 20
  autoscale_min_write_capacity = 5
  autoscale_max_write_capacity = 20
  enable_autoscaler            = "true"

  dynamodb_attributes = [
    {
      name = "DailyAverage"
      type = "N"
    },
    {
      name = "HighWater"
      type = "N"
    },
    {
      name = "Timestamp"
      type = "S"
    },
  ]

  local_secondary_index_map = [
    {
      name               = "TimestampSortIndex"
      range_key          = "Timestamp"
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    },
    {
      name               = "HighWaterIndex"
      range_key          = "Timestamp"
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    },
  ]

  global_secondary_index_map = [
    {
      name               = "DailyAverageIndex"
      hash_key           = "DailyAverage"
      range_key          = "HighWater"
      write_capacity     = 5
      read_capacity      = 5
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    },
    {
      name            = "HighWaterIndex"
      hash_key        = "HighWater"
      write_capacity  = 5
      read_capacity   = 5
      projection_type = "KEYS_ONLY"
    },
  ]
}
```

## Running The Example
Check out this module and switch to this directory.

Ensure the depedencies are installed
```
terraform init
```

Run a plan
```
terraform plan
```

Apply the plan
```
terraform apply
```

Destroy the resources
```
terraform destroy
```
