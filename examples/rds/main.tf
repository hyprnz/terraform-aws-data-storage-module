module "example_datastore_rds" {
  source = "../../"

  create_rds_instance = true
  name                = "example"
  rds_identifier      = "example-postgres-dev"

  rds_subnet_group       = "example-group"
  rds_security_group_ids = ["sg-0123456789"]

  rds_password = "reallylongpassword"
}
