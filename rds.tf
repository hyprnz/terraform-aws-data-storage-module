locals {
  username = length(var.rds_username) > 0 ? format("%suser", var.rds_username) : format("%suser", var.rds_database_name)
}

resource "aws_db_instance" "this" {
  count = local.count_rds_instance

  db_name        = var.rds_database_name
  identifier     = var.rds_identifier
  engine         = var.rds_engine
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class

  username = local.username
  password = var.rds_password

  parameter_group_name = local.count_rds_parameter_group > 0 ? var.rds_parameter_group_name : null

  iam_database_authentication_enabled = var.rds_iam_authentication_enabled
  enabled_cloudwatch_logs_exports     = var.rds_cloudwatch_logs_exports
  option_group_name                   = var.rds_option_group_name
  apply_immediately                   = var.rds_apply_immediately
  auto_minor_version_upgrade          = var.rds_auto_minor_version_upgrade
  db_subnet_group_name                = var.rds_subnet_group
  vpc_security_group_ids              = var.rds_security_group_ids
  allocated_storage                   = var.rds_allocated_storage
  max_allocated_storage               = var.rds_max_allocated_storage
  backup_retention_period             = var.backup_retention_period
  iops                                = var.rds_iops
  multi_az                            = var.rds_multi_az
  monitoring_interval                 = var.rds_monitoring_interval
  monitoring_role_arn                 = var.rds_monitoring_role_arn
  performance_insights_enabled        = var.rds_enable_performance_insights
  backup_window                       = var.rds_backup_window
  skip_final_snapshot                 = var.rds_skip_final_snapshot
  final_snapshot_identifier           = var.rds_final_snapshot_identifier
  storage_encrypted                   = var.rds_enable_storage_encryption
  kms_key_id                          = var.rds_storage_encryption_kms_key_arn
  deletion_protection                 = var.rds_enable_deletion_protection
  tags = merge(
    {
      "Name"       = var.rds_identifier,
      "rds_engine" = var.rds_engine
    },
    var.tags,
    var.rds_tags,
  )

  // We need this dependency because we only pass the var `rds_parameter_group_name` rather than reference the resource.
  // Terraform can't tell that it needs to wait for it to be created based on the name alone.
  depends_on = [
    aws_db_parameter_group.db_parameter_group
  ]
}

data "aws_db_snapshot" "latest_snapshot" {
  count = local.count_rds_instance_with_snapshot

  db_instance_identifier = var.rds_identifier
  most_recent            = true
}

resource "aws_db_instance" "snapshot" {
  count = local.count_rds_instance_with_snapshot

  db_name           = var.rds_database_name
  identifier     = var.rds_identifier
  engine         = var.rds_engine
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class

  username = local.username
  password = var.rds_password

  snapshot_identifier = data.aws_db_snapshot.latest_snapshot[0].id

  option_group_name            = var.rds_option_group_name
  apply_immediately            = var.rds_apply_immediately
  auto_minor_version_upgrade   = var.rds_auto_minor_version_upgrade
  db_subnet_group_name         = var.rds_subnet_group
  vpc_security_group_ids       = var.rds_security_group_ids
  allocated_storage            = var.rds_allocated_storage
  max_allocated_storage        = var.rds_max_allocated_storage
  backup_retention_period      = var.backup_retention_period
  iops                         = var.rds_iops
  multi_az                     = var.rds_multi_az
  monitoring_interval          = var.rds_monitoring_interval
  monitoring_role_arn          = var.rds_monitoring_role_arn
  performance_insights_enabled = var.rds_enable_performance_insights
  backup_window                = var.rds_backup_window
  skip_final_snapshot          = var.rds_skip_final_snapshot
  final_snapshot_identifier    = var.rds_final_snapshot_identifier
  storage_encrypted            = var.rds_enable_storage_encryption
  kms_key_id                   = var.rds_storage_encryption_kms_key_arn
  deletion_protection          = var.rds_enable_deletion_protection
  tags = merge(
    {
      "Name"       = var.rds_identifier,
      "rds_engine" = var.rds_engine
    },
    var.tags,
    var.rds_tags,
  )

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }
}

resource "aws_db_parameter_group" "db_parameter_group" {
  count = local.count_rds_parameter_group

  name   = var.rds_parameter_group_name
  family = var.rds_parameter_group_family

  dynamic "parameter" {
    for_each = var.rds_parameter_group_parameters
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "pending-reboot"
    }
  }

  tags = merge(
    {
      "Name"       = var.rds_identifier,
      "rds_engine" = var.rds_engine
    },
    var.tags,
    var.rds_tags,
  )
}
