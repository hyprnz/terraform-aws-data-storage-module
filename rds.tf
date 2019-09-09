resource "aws_db_instance" "this" {
  count = "${var.enable_datastore && var.create_rds_instance ? 1 : 0}"

  name           = "${var.name}"
  identifier     = "${var.rds_identifier}"
  engine         = "${var.rds_engine}"
  engine_version = "${var.rds_engine_version}"
  instance_class = "${var.rds_instance_class}"

  username = "${format("%s-db-user",var.name)}"

  # password                = "${var.db_password}"

  db_subnet_group_name   = "${var.rds_subnet_group}"
  vpc_security_group_ids = "${var.rds_security_group_ids}"
  allocated_storage       = "${var.rds_allocated_storage}"
  backup_retention_period = "${var.backup_retention_period}"
  iops                    = "${var.rds_iops}"
  monitoring_interval     = "${var.rds_monitoring_interval}"
  backup_window           = "${var.rds_backup_window}"
  skip_final_snapshot     = "${var.rds_skip_final_snapshot}"
  storage_encrypted       = "${var.rds_storage_encrypted}"
  kms_key_id              = "${var.rds_storage_encryption_kms_key_arn}"
  tags = "${merge(var.tags, var.rds_tags)}"
}
