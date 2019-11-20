module "example_datastore_rds" {
  source = "../../"

  providers {
    aws = "aws"
  }

  create_rds_instance = true
  name                = "example"
  rds_identifier      = "example-postgres-dev"

  rds_subnet_group       = "example-group"
  rds_security_group_ids = ["sg-0123456789"]

  rds_password = "reallylongpassword"
}

provider "aws" {
  region = "ap-southeast-2"
}

output "endpoint" {
  value = "${module.example_datastore_rds.rds_instance_endpoint}"
}

output "instance_is" {
  value = "${module.example_datastore_rds.rds_instance_id}"
}

output "db_name" {
  value = "${module.example_datastore_rds.rds_db_name}"
}

output "db_user" {
  value = "${module.example_datastore_rds.rds_db_user}"
}

output "db_url" {
  value = "${module.example_datastore_rds.rds_db_url}"
}
