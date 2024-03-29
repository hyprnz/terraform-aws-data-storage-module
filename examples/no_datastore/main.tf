module "example_no_datastore" {
  source = "../../"

  providers = {
    aws = aws
  }

  enable_datastore = false
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


output "endpoint" {
  value = module.example_no_datastore.rds_instance_endpoint
}

output "instance_is" {
  value = module.example_no_datastore.rds_instance_id
}

output "db_name" {
  value = module.example_no_datastore.rds_db_name
}

output "db_user" {
  value = module.example_no_datastore.rds_db_user
}

output "db_url" {
  value = module.example_no_datastore.rds_db_url
}

