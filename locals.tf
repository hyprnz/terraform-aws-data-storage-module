locals {
  create_s3        = var.enable_datastore && var.create_s3_bucket ? 1 : 0
  create_dynamodb  = var.enable_datastore && var.create_dynamo_db_table
}

