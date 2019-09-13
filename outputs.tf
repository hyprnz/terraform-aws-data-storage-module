output "rds_instance_address" {
  description = "The address of the RDS instance"
  value       = "${aws_db_instance.this.*.address}"
}

output "rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${aws_db_instance.this.*.arn}"
}

output "rds_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${aws_db_instance.this.*.endpoint}"
}

output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = "${aws_db_instance.this.*.id}"
}

output "rds_db_name" {
  description = "The name of the rds database"
  value       = "${aws_db_instance.this.*.name}"
}

output "rds_db_user" {
  description = "The RDS db username"
  value       = "${aws_db_instance.this.*.username}"
}

output "rds_db_url" {
  description = "The connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name`"
  value       = "${format("%s://%s:%s@%s/%s", var.rds_engine, aws_db_instance.this.0.username, var.rds_password, aws_db_instance.this.0.endpoint, aws_db_instance.this.0.name )}"
}
