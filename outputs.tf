output "rds_instance_address" {
  description = "The address of the RDS instance"
  value       = element(concat(aws_db_instance.this.*.address, aws_db_instance.snapshot.*.address, [""]), 0)
}

output "rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = element(concat(aws_db_instance.this.*.arn, aws_db_instance.snapshot.*.arn, [""]), 0)
}

output "rds_instance_endpoint" {
  description = "The connection endpoint"
  value       = element(concat(aws_db_instance.this.*.endpoint, aws_db_instance.snapshot.*.endpoint, [""]), 0)
}

output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = element(concat(aws_db_instance.this.*.id, aws_db_instance.snapshot.*.id, [""]), 0)
}

output "rds_db_name" {
  description = "The name of the rds database"
  value       = element(concat(aws_db_instance.this.*.name, aws_db_instance.snapshot.*.name, [""]), 0)
}

output "rds_db_user" {
  description = "The RDS db username"
  value       = element(concat(aws_db_instance.this.*.username, aws_db_instance.snapshot.*.username, [""]), 0)
}

output "rds_db_url" {
  description = "The connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name`"
  value = element(concat(aws_db_instance.this.*.username, aws_db_instance.snapshot.*.username, [""]), 0) == "" ? "" : format(
    "%s://%s:%s@%s/%s",
    var.rds_engine,
    element(concat(aws_db_instance.this.*.username, aws_db_instance.snapshot.*.username, [""]), 0),
    var.rds_password,
    element(concat(aws_db_instance.this.*.endpoint, aws_db_instance.snapshot.*.endpoint, [""]), 0),
    element(concat(aws_db_instance.this.*.name, aws_db_instance.snapshot.*.name, [""]), 0),
  )
}

output "rds_db_url_encoded" {
  description = "The connection url in the format of `engine`://`user`:`ulrencode(password)`@`endpoint`/`db_name`"
  value = element(concat(aws_db_instance.this.*.username, aws_db_instance.snapshot.*.username, [""]), 0) == "" ? "" : format(
    "%s://%s:%s@%s/%s",
    var.rds_engine,
    element(concat(aws_db_instance.this.*.username, aws_db_instance.snapshot.*.username, [""]), 0),
    urlencode(var.rds_password),
    element(concat(aws_db_instance.this.*.endpoint, aws_db_instance.snapshot.*.endpoint, [""]), 0),
    element(concat(aws_db_instance.this.*.name, aws_db_instance.snapshot.*.name, [""]), 0),
  )
}

output "rds_engine_version" {
  description = "The actual engine version used by the RDS instance."
  value       = element(concat(aws_db_instance.this[*].engine_version_actual, aws_db_instance.snapshot[*].engine_version_actual, [""]), 0)
}

output "s3_bucket" {
  description = "The name of the bucket"
  value       = join(",", aws_s3_bucket.this.*.bucket)
}

output "s3_bucket_policy_arn" {
  description = "Policy arn to be attached to a execution role defined in the parent module"
  value       = join(",", aws_iam_policy.s3_datastore_bucket[*].arn)
}

output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = join(",", aws_dynamodb_table.this[*].name)
}

output "dynamodb_table_id" {
  description = "DynamoDB table ID"
  value       = join(",", aws_dynamodb_table.this[*].id)
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  value       = join(",", aws_dynamodb_table.this[*].arn)
}

output "dynamodb_global_secondary_index_names" {
  description = "DynamoDB secondary index names"
  value       = null_resource.global_secondary_index_names[*].triggers.name
}

output "dynamodb_local_secondary_index_names" {
  description = "DynamoDB local index names"
  value       = null_resource.local_secondary_index_names[*].triggers.name
}

output "dynamodb_table_stream_arn" {
  description = "DynamoDB table stream ARN"
  value       = join(",", aws_dynamodb_table.this[*].stream_arn)
}

output "dynamodb_table_stream_label" {
  description = "DynamoDB table stream label"
  value       = join(",", aws_dynamodb_table.this[*].stream_label)
}

output "dynamodb_table_policy_arn" {
  description = "Policy arn to be attached to an execution role defined in the parent module."
  value       = join("", aws_iam_policy.dynamodb_table_datastore[*].arn)
}

