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
