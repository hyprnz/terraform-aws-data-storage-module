# Terraform DynamoDB Module Base Terraform Example
A simple Terraform implementation using the Terraform DynamoDB module

The base example has autoscaling enabled but does not add any additional
DynamoDB attributes, [local secondary
index](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LSI.html)
maps or [global secondary
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
