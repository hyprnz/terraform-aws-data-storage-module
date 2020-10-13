variable "enabled" {
  description = "Whether or not to create the modules resources"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags (e.g map(`BusinessUnit`,`XYX`)"
  type        = map
  default     = {}
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  type        = string
}

variable "dynamodb_indexes" {
  description = "List of DynamoDB indexes"
  type        = list
  default     = []
}

variable "autoscale_read_target" {
  description = "The target value (in %) for DynamoDB read autoscaling"
  type        = number
  default     = 50
}

variable "autoscale_write_target" {
  description = "The target value (in %) for DynamoDB write autoscaling"
  type        = number
  default     = 50
}

variable "autoscale_min_read_capacity" {
  description = "DynamoDB autoscaling min read capacity"
  type        = number
  default     = 5
}

variable "autoscale_min_write_capacity" {
  description = "DynamoDB autoscaling min write capacity"
  type        = number
  default     = 5
}

variable "autoscale_max_read_capacity" {
  description = "DynamoDB autoscaling max read capacity"
  type        = number
  default     = 20
}

variable "autoscale_max_write_capacity" {
  description = "DynamoDB autoscaling max write capacity"
  type        = number
  default     = 20
}
