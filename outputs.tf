output "rds_instance_address" {
  description = "The address of the RDS instance"
  value       = "${element(concat(aws_db_instance.this.*.address, list("")),0)}"
}

output "rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${element(concat(aws_db_instance.this.*.arn, list("")), 0)}"
}

output "rds_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${element(concat(aws_db_instance.this.*.endpoint, list("")), 0)}"
}

output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = "${element(concat(aws_db_instance.this.*.id, list("")), 0)}"
}

output "rds_db_name" {
  description = "The name of the rds database"
  value       = "${element(concat(aws_db_instance.this.*.name, list("")), 0)}"
}

output "rds_db_user" {
  description = "The RDS db username"
  value       = "${element(concat(aws_db_instance.this.*.username, list("")), 0)}"
}

output "rds_db_url" {
  description = "The connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name`"
  value       = "${element(concat(aws_db_instance.this.*.username, list("")), 0) == "" ? "" : format("%s://%s:%s@%s/%s", var.rds_engine, element(concat(aws_db_instance.this.*.username, list("")),0), var.rds_password, element(concat(aws_db_instance.this.*.endpoint, list("")), 0), element(concat(aws_db_instance.this.*.name, list("")), 0) )}"
}

output "s3_bucket" {
  description = "The name of the bucket"
  value       = "${join(",", aws_s3_bucket.this.*.bucket)}"
}

output "s3_bucket_role_name" {
  description = "The name of the IAm role with access policy"
  value       = "${join(",", aws_iam_role.s3_datastore_bucket.*.name)}"
}