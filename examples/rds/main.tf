resource "aws_vpc" "db_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "db_subnet_a" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = "${aws_vpc.db_vpc.id}"
  availability_zone = "ap-southeast-2a"
}

resource "aws_subnet" "db_subnet_b" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = "${aws_vpc.db_vpc.id}"
  availability_zone = "ap-southeast-2b"
}

resource "aws_db_subnet_group" "db_subnetgroup" {
  subnet_ids = ["${aws_subnet.db_subnet_a.id}", "${aws_subnet.db_subnet_b.id}"]
  name       = "example-group"
}

resource "aws_security_group" "db_security_group" {
  vpc_id = "${aws_vpc.db_vpc.id}"

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
}

module "example_datastore_rds" {
  source = "../../"



  create_rds_instance    = true
  rds_database_name      = "test_db_postgress"
  rds_identifier         = "example-postgres-dev"
  rds_subnet_group       = "${aws_db_subnet_group.db_subnetgroup.name}"
  rds_security_group_ids = ["${aws_security_group.db_security_group.id}"]
  rds_password           = "reallylongpassword"
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
