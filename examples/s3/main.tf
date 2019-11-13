module "example_s3_datastore" {
  source = "../../"

  providers {
    aws = "aws"
  }

  enable_datastore    = true
  create_s3_bucket    = true
  name                = "s3-datastore"
  s3_bucket_namespace = "stage.example.com"

  s3_bucket_K8s_worker_iam_role_arn = "arn:aws:iam::0123456789:role/eks-worker-role"
}

provider "aws" {
  region = "ap-southeast-2"
}


output "bucket_name" {
  value = "${module.example_s3_datastore.s3_bucket}"
}

output "bucket_role_name" {
  value = "${module.example_s3_datastore.s3_bucket_role_name}"
}
