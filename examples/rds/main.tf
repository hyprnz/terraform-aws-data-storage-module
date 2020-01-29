data "aws_vpcs" "default" {
  filter {
    name = "isDefault"
    values = ["true"]
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = tolist(data.aws_vpcs.default.ids)[0]
}

resource "aws_db_subnet_group" "db_subnetgroup" {
  subnet_ids = data.aws_subnet_ids.default.ids
  name       = "data-storage-rds-example"
}

resource "aws_security_group" "db_security_group" {
  vpc_id = tolist(data.aws_vpcs.default.ids)[0]

  ingress {
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = map("Name", "data-storage-rds-example-security-group")
}

module "example_datastore_rds" {
  source = "../../"

  providers = {
    aws = aws
  }

  create_rds_instance = true
  rds_database_name   = "example"
  rds_identifier      = "example-postgres-dev"

  rds_subnet_group       = aws_db_subnet_group.db_subnetgroup.name
  rds_security_group_ids = [aws_security_group.db_security_group.id]

  rds_password = "reallylongpassword"
}

variable "aws_region" {
  default = "ap-southeast-2"
}

output "debug_vpc_id" {
  value = data.aws_vpcs.default.ids
}

output "debug_subnet_ids" {
  value = data.aws_subnet_ids.default.ids
}

output "debug_subgroup_name" {
  value = aws_db_subnet_group.db_subnetgroup.name
}

output "endpoint" {
  value = module.example_datastore_rds.rds_instance_endpoint
}

output "instance_is" {
  value = module.example_datastore_rds.rds_instance_id
}

output "db_name" {
  value = module.example_datastore_rds.rds_db_name
}

output "db_user" {
  value = module.example_datastore_rds.rds_db_user
}

output "db_url" {
  value = module.example_datastore_rds.rds_db_url
}
