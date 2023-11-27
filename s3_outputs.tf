output "s3_bucket_name" {
  description = "The name of the bucket"
  value       = join(",", aws_s3_bucket.this[*].bucket)
}

output "s3_bucket_policy_arn" {
  description = "Policy arn to be attached to a execution role defined in the parent module"
  value       = join(",", aws_iam_policy.s3_datastore_bucket[*].arn)
}
