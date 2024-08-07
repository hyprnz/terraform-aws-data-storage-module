variable "enable_datastore" {
  type        = bool
  description = "Enables the data store module that will provision data storage resources"
  default     = true
}

variable "iam_resource_path" {
  type        = string
  description = "The path for IAM roles and policies"
  default     = "/"
}

variable "tags" {
  type        = map(any)
  description = "Tags for all datastore resources"
  default     = {}
}
