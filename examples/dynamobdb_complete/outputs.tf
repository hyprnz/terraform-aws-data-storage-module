output "table_name" {
  description = "DynamoDB table name"
  value       = "${module.example_dynamodb_complete.dynamodb_table_name}"
}

output "table_id" {
  description = "DynamoDB table ID"
  value       = "${module.example_dynamodb_complete.dynamodb_table_id}"
}

output "table_arn" {
  description = "DynamoDB table ARN"
  value       = "${module.example_dynamodb_complete.dynamodb_table_arn}"
}

output "global_secondary_index_names" {
  description = "DynamoDB secondary index names"
  value       = "${module.example_dynamodb_complete.dynamodb_global_secondary_index_names}"
}

output "local_secondary_index_names" {
  description = "DynamoDB local index names"
  value       = "${module.example_dynamodb_complete.dynamodb_local_secondary_index_names}"
}

output "table_stream_arn" {
  description = "DynamoDB table stream ARN"
  value       = "${module.example_dynamodb_complete.dynamodb_table_stream_arn}"
}

output "table_stream_label" {
  description = "DynamoDB table stream label"
  value       = "${module.example_dynamodb_complete.dynamodb_table_stream_label}"
}
