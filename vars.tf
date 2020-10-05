variable "enable_datastore" {
  description = "Enables the data store module that will provision data storage resources"
  default     = true
}

variable "create_rds_instance" {
  description = "Controls if an RDS instance should be provisioned."
  default     = false
}

variable "use_rds_snapshot" {
  description = "Controls if an RDS snapshot should be used."
  default     = false
}

variable "rds_database_name" {
  description = "Name of the database"
  default     = ""
}

variable "rds_identifier" {
  description = "Identifier of datastore instance"
  default     = ""
}

variable "rds_engine" {
  description = "The Database engine for the rds instance"
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "The version of the database engine."
  default     = 11.4
}

variable "rds_instance_class" {
  description = "The instance type to use"
  default     = "db.t3.small"
}

variable "rds_subnet_group" {
  description = "Subnet group for RDS instances"
  default     = ""
}

variable "rds_security_group_ids" {
  description = "A List of security groups to bind to the rds instance"
  type        = list(string)
  default     = []
}

variable "rds_allocated_storage" {
  description = "Amount of storage allocated to RDS instance"
  default     = 10
}

variable "rds_max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to `allocated_storage`. Must be greater than or equal to `allocated_storage` or `0` to disable Storage Autoscaling."
  default     = 0
}

variable "backup_retention_period" {
  description = "The backup retention period in days"
  default     = 7
}

variable "rds_option_group_name" {
  description = "Name of the DB option group to associate"
  type        = string
  default     = null
}

variable "rds_iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  default     = 0
}

variable "rds_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "rds_monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  default     = ""
}

variable "rds_enable_performance_insights" {
  description = "Controls the enabling of RDS Performance insights. Default to `true`"
  default     = true
}

variable "rds_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default     = "16:19-16:49"
}

variable "rds_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  default     = true
}

variable "rds_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  default     = false
}

variable "rds_storage_encryption_kms_key_arn" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default     = ""
}

variable "rds_username" {
  description = "RDS database user name"
  type        = string
  default     = ""
}

variable "rds_password" {
  description = "RDS database password for the user"
  default     = ""
}

variable "rds_tags" {
  description = "Additional tags for rds datastore resources"
  default     = {}
}

variable "create_s3_bucket" {
  description = "Controls if an S3 bucket should be provisioned"
  default     = false
}

variable "s3_bucket_name" {
  description = "The name of the bucket"
  default     = ""
}

variable "s3_bucket_namespace" {
  description = "The namespace of the bucket - intention is to help avoid naming collisions"
  default     = ""
}

variable "s3_enable_versioning" {
  description = "If versioning should be configured on the bucket"
  default     = true
}

variable "s3_tags" {
  description = "Additional tags to be added to the s3 resources"
  default     = {}
}

variable "tags" {
  description = "Tags for all datastore resources"
  default     = {}
}

