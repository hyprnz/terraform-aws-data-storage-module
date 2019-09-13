module "example_datastore_rds" {
  source = "../../"

  create_rds_instance = true
  name                = "example"
  rds_identifier      = "example-postgres-dev"

  rds_subnet_group       = "example-group"
  rds_security_group_ids = ["sg-0123456789"]

  rds_password = "reallylongpassword"
}

output "endpoint" {
  value = "${module.example_datastore_rds.rds_instance_endpoint[0]}"
}

output "instance_is" {
  value = "${module.example_datastore_rds.rds_instance_id[0]}"
}

output "db_name" {
  value = "${module.example_datastore_rds.rds_db_name[0]}"
}

output "db_user" {
  value = "${module.example_datastore_rds.rds_db_user[0]}"
}

output "db_url" {
  value = "${module.example_datastore_rds.rds_db_url}"
}
