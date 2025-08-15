locals {
  create_s3 = var.enable_datastore && var.create_s3_bucket
  count_s3  = local.create_s3 ? 1 : 0
  count_s3_notifications = local.create_s3 && var.s3_send_bucket_notifications_to_eventbridge ? 1 : 0

  create_dynamodb          = var.enable_datastore && var.create_dynamodb_table
  create_dynamodb_insights = var.enable_datastore && var.create_dynamodb_table && var.dynamodb_enable_insights
  count_dynamodb           = local.create_dynamodb ? 1 : 0
  count_dynamodb_insights  = local.create_dynamodb_insights ? 1 : 0
  create_rds_instance      = var.enable_datastore && var.create_rds_instance
  count_rds_instance       = local.create_rds_instance ? 1 : 0

  create_rds_instance_with_snapshot = var.enable_datastore && var.use_rds_snapshot && (!local.create_rds_instance)
  count_rds_instance_with_snapshot  = local.create_rds_instance_with_snapshot ? 1 : 0

  create_rds_instance_with_parameter_group = var.create_rds_instance && var.rds_parameter_group_name != null && var.rds_parameter_group_family != null
  count_rds_parameter_group                = local.create_rds_instance_with_parameter_group ? 1 : 0
}

