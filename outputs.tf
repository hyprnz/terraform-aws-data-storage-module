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

output "rds_rds_user" {
  description = "The RDS db username"
  value       = "${aws_db_instance.this.*.username}"
}

