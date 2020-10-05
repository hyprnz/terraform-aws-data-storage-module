module "example_s3_datastore" {
  source = "../../"

  providers = {
    aws = aws
  }

  enable_datastore    = true
  create_s3_bucket    = true
  s3_bucket_name      = "s3-datastore"
  s3_bucket_namespace = "stage.example.com"
}

provider "aws" {
  region = "ap-southeast-2"
}

output "bucket_name" {
  value = "${module.example_s3_datastore.s3_bucket}"
}

output "bucket_policy_arn" {
  value = "${module.example_s3_datastore.s3_bucket_policy_arn}"
}
