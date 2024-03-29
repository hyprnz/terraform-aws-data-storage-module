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
  value       = element(concat(aws_db_instance.this.*.db_name, aws_db_instance.snapshot.*.name, [""]), 0)
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
    element(concat(aws_db_instance.this.*.db_name, aws_db_instance.snapshot.*.name, [""]), 0),
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
    element(concat(aws_db_instance.this.*.db_name, aws_db_instance.snapshot.*.name, [""]), 0),
  )
}

output "rds_engine_version" {
  description = "The actual engine version used by the RDS instance."
  value       = element(concat(aws_db_instance.this[*].engine_version_actual, aws_db_instance.snapshot[*].engine_version_actual, [""]), 0)
}