locals {
  create_s3 = var.enable_datastore && var.create_s3_bucket
  count_s3  = local.create_s3 ? 1 : 0

  create_dynamodb = var.enable_datastore && var.create_dynamodb_table
  count_dynamodb  = local.create_dynamodb ? 1 : 0
}

