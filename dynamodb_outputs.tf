output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = try(aws_dynamodb_table.this[0].name, "")
}

output "dynamodb_table_id" {
  description = "DynamoDB table ID"
  value       = try(aws_dynamodb_table.this[0].id, "")
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  value       = try(aws_dynamodb_table.this[0].arn, "")
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
  value       = try(aws_dynamodb_table.this[0].stream_arn, "")
}

output "dynamodb_table_stream_label" {
  description = "DynamoDB table stream label"
  value       = try(aws_dynamodb_table.this[0].stream_label, "")
}

output "dynamodb_table_policy_arn" {
  description = "Policy arn to be attached to an execution role defined in the parent module."
  value       = try(aws_iam_policy.dynamodb_table_datastore[0].arn, "")
}
