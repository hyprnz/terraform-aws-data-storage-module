output "this_db_instance_address" {
  description = "The address of the RDS instance"
  value       = "${aws_db_instance.this.*.address}"
}

output "this_db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${aws_db_instance.this.*.arn}"
}

output "this_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${aws_db_instance.this.*.endpoint}"
}

output "this_db_instance_id" {
  description = "The RDS instance ID"
  value       = "${aws_db_instance.this.*.id}"
}
