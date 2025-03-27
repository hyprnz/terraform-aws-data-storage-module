provider "aws" {
  region = "ap-southeast-2"
}

variables {
  enable_datastore                = true
  create_rds_instance             = true
  rds_identifier                  = "test-rds-instance"
  rds_database_name               = "testdb"
  rds_engine                      = "postgres"
  rds_engine_version              = "13"
  rds_instance_class              = "db.t3.micro"
  rds_allocated_storage           = 20
  rds_username                    = "testuser"
  rds_password                    = "testpassword123"
  rds_skip_final_snapshot         = true
  rds_enable_storage_encryption   = true
  rds_enable_performance_insights = true
  rds_backup_retention_period     = 7
  rds_backup_window               = "03:00-04:00"
  rds_maintenance_window          = "Mon:04:00-Mon:05:00"
  rds_auto_minor_version_upgrade  = true
  rds_multi_az                    = false
  rds_parameter_group_family      = "postgres13"
  rds_parameter_group_name        = "test-parameter-group"
  rds_parameter_group_parameters = {
    "max_connections" = "100"
    "shared_buffers"  = "256"
  }
}

run "ensure_clean_state" {
  command = plan
  variables {
    enable_datastore    = false
    create_rds_instance = false
  }

  assert {
    condition     = length(aws_db_instance.this) == 0
    error_message = "RDS instance should not exist before running tests"
  }
}

run "rds_locals_username" {
  command = plan
  variables {
    rds_username = "testuser"
  }

  assert {
    condition     = local.username == "testuseruser"
    error_message = "RDS username is incorrect"
  }
}

run "rds_locals_default_username" {
  command = plan
  variables {
    rds_database_name = "testdb"
    rds_username = ""
  }

  assert {
    condition     = local.username == "testdbuser"
    error_message = "RDS username is incorrect"
  }
}

run "rds_instance_creation" {
  command = plan

  assert {
    condition     = aws_db_instance.this[0].allocated_storage == 20
    error_message = "RDS instance storage size is incorrect"
  }

  assert {
    condition     = aws_db_instance.this[0].engine == "postgres"
    error_message = "RDS engine type is incorrect"
  }

  assert {
    condition     = aws_db_instance.this[0].instance_class == "db.t3.micro"
    error_message = "RDS instance class is incorrect"
  }

  assert {
    condition     = aws_db_instance.this[0].db_name == "testdb"
    error_message = "RDS database name is incorrect"
  }

  assert {
    condition     = aws_db_instance.this[0].username == "testuseruser"
    error_message = "RDS username is incorrect"
  }
}

run "rds_instance_encryption" {
  command = plan

  assert {
    condition     = aws_db_instance.this[0].storage_encrypted == true
    error_message = "RDS storage encryption should be enabled"
  }
}

run "rds_instance_performance_insights" {
  command = plan

  assert {
    condition     = aws_db_instance.this[0].performance_insights_enabled == true
    error_message = "RDS performance insights should be enabled"
  }
}

run "rds_instance_backup" {
  command = plan

  assert {
    condition     = aws_db_instance.this[0].backup_retention_period == 7
    error_message = "RDS backup retention period is incorrect"
  }

  assert {
    condition     = aws_db_instance.this[0].backup_window == "03:00-04:00"
    error_message = "RDS backup window is incorrect"
  }
}


run "rds_instance_parameter_group" {
  command = plan

  assert {
    condition     = aws_db_instance.this[0].parameter_group_name == "test-parameter-group"
    error_message = "RDS parameter group name is incorrect"
  }
}

run "rds_instance_not_created_when_disabled" {
  variables {
    enable_datastore    = false
    create_rds_instance = false
  }

  command = plan

  assert {
    condition     = length(aws_db_instance.this) == 0
    error_message = "RDS instance should not be created when disabled"
  }
}

run "rds_instance_multi_az" {
  variables {
    rds_multi_az = true
  }

  command = plan

  assert {
    condition     = aws_db_instance.this[0].multi_az == true
    error_message = "RDS multi-AZ should be enabled"
  }
}

run "rds_instance_deletion_protection" {
  variables {
    rds_enable_deletion_protection = true
  }

  command = plan

  assert {
    condition     = aws_db_instance.this[0].deletion_protection == true
    error_message = "RDS deletion protection should be enabled"
  }
}

run "rds_instance_iam_auth" {
  variables {
    rds_iam_authentication_enabled = true
    rds_identifier = "test-rds-instance-iam"
  }

  command = plan

  assert {
    condition     = aws_db_instance.this[0].iam_database_authentication_enabled == true
    error_message = "RDS IAM authentication should be enabled"
  }
}
