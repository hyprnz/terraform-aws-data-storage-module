module "example_dynamodb_complete" {
  source = "../../"

  providers = {
    aws = aws
  }

  enable_datastore      = true
  create_dynamodb_table = true

  dynamodb_table_name                   = "App-Env-Example-Complete"
  dynamodb_hash_key                     = "HashKey"
  dynamodb_range_key                    = "RangeKey"
  dynamodb_autoscale_write_target       = 50
  dynamodb_autoscale_read_target        = 50
  dynamodb_autoscale_min_read_capacity  = 5
  dynamodb_autoscale_max_read_capacity  = 20
  dynamodb_autoscale_min_write_capacity = 5
  dynamodb_autoscale_max_write_capacity = 20
  dynamodb_enable_autoscaler            = true

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

  dynamodb_local_secondary_index_map = [
    {
      name               = "TimestampSortIndex"
      range_key          = "Timestamp"
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    },
    {
      name               = "HighWaterTSIndex"
      range_key          = "Timestamp"
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    },
  ]

  dynamodb_global_secondary_index_map = [
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

provider "aws" {
  region = var.region
}

variable "region" {
  default = "ap-southeast-2"
}
