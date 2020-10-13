
module "example_dynamodb_base" {
  source = "../../"

  providers = {
    aws = aws
  }

  enable_datastore      = true
  create_dynamodb_table = true

  dynamodb_table_name                   = "App-Env-Example"
  dynamodb_hash_key                     = "HashKey"
  dynamodb_range_key                    = "RangeKey"
  dynamodb_autoscale_write_target       = 50
  dynamodb_autoscale_read_target        = 50
  dynamodb_autoscale_min_read_capacity  = 5
  dynamodb_autoscale_max_read_capacity  = 20
  dynamodb_autoscale_min_write_capacity = 5
  dynamodb_autoscale_max_write_capacity = 20
  dynamodb_enable_autoscaler            = true
}

provider "aws" {
  region = var.region
}

variable "region" {
  default = "ap-southeast-2"
}
