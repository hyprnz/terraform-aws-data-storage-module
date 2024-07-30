module "example_s3_datastore" {
  source = "../../"

  providers = {
    aws = aws
  }

  enable_datastore = true
  create_s3_bucket = true
  s3_bucket_name   = "s3-datastore-env-example"
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

output "bucket_name" {
  value = module.example_s3_datastore.s3_bucket_name
}

output "bucket_policy_arn" {
  value = module.example_s3_datastore.s3_bucket_policy_arn
}
