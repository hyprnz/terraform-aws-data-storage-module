module "example_no_datastore" {
  source = "../../"

  providers = {
    aws = aws
  }

  enable_datastore = var.enable_datastore
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment"    = "stage",
      "Resource Owner" = "terraform-aws-data-storage-module example s3"
      "Managed By"     = "Terraform"
    }
  }
}

variable "region" {
  default = "ap-southeast-2"
}

variable "enable_datastore" {
  type    = bool
  default = false
}


output "db_name" {
  value = module.example_no_datastore.rds_db_name
}

output "ddb_table_name" {
  value = module.example_no_datastore.dynamodb_table_name
}

output "s3_bucket_name" {
  value = module.example_no_datastore.s3_bucket_name
}





