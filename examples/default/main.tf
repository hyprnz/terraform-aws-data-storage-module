module "example_default" {
  source = "../../"

  providers = {
    aws = aws
  }

  enable_datastore      = true
  create_dynamodb_table = var.create_dynamodb_table

  dynamodb_table_name      = var.dynamodb_table_name
  dynamodb_hash_key        = var.dynamodb_hash_key
  dynamodb_hash_key_type   = var.dynamodb_hash_key_type
  dynamodb_range_key       = var.dynamodb_range_key
  dynamodb_range_key_type  = var.dynamodb_range_key_type
  dynamodb_billing_mode    = var.dynamodb_billing_mode
  dynamodb_enable_insights = var.dynamodb_enable_insights
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment" = "env",
      "Managed By"  = "IaC"
    }
  }
}

variable "region" {
  default = "us-west-2"
}
