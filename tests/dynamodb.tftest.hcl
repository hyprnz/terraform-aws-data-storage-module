provider "aws" {
  region = "ap-southeast-2"
}

variables {
  enable_datastore                       = true
  create_dynamodb_table                  = true
  dynamodb_table_name                    = "test-dynamodb-table"
  dynamodb_billing_mode                  = "PROVISIONED"
  dynamodb_hash_key                      = "PK"
  dynamodb_hash_key_type                 = "S"
  dynamodb_range_key                     = "SK"
  dynamodb_range_key_type                = "S"
  dynamodb_enable_encryption             = true
  dynamodb_enable_point_in_time_recovery = true
  dynamodb_enable_streams                = false
  dynamodb_ttl_enabled                   = true
  dynamodb_ttl_attribute                 = "Expires"
  dynamodb_autoscale_min_read_capacity   = 5
  dynamodb_autoscale_max_read_capacity   = 20
  dynamodb_autoscale_min_write_capacity  = 5
  dynamodb_autoscale_max_write_capacity  = 20
  dynamodb_autoscale_read_target         = 50
  dynamodb_autoscale_write_target        = 50
  dynamodb_enable_autoscaler             = true
  dynamodb_enable_iam_policy             = true
  dynamodb_attributes = [
    {
      name = "PK"
      type = "S"
    },
    {
      name = "SK"
      type = "S"
    },
    {
      name = "GSI1PK"
      type = "S"
    },
    {
      name = "GSI1SK"
      type = "S"
    },
    {
      name = "LSI1SK"
      type = "S"
    }
  ]
  dynamodb_global_secondary_index_map = [
    {
      name               = "GSI1"
      hash_key           = "GSI1PK"
      hash_key_type      = "S"
      range_key          = "GSI1SK"
      range_key_type     = "S"
      projection_type    = "ALL"
      read_capacity      = 5
      write_capacity     = 5
      include_properties = ["read_capacity", "write_capacity"]
    }
  ]
  dynamodb_local_secondary_index_map = [
    {
      name            = "LSI1"
      range_key       = "LSI1SK"
      range_key_type  = "S"
      projection_type = "ALL"
    }
  ]
}

run "dynamodb_table_creation" {
  command = plan

  assert {
    condition     = aws_dynamodb_table.this[0].billing_mode == "PROVISIONED"
    error_message = "DynamoDB billing mode is incorrect"
  }

  assert {
    condition     = aws_dynamodb_table.this[0].hash_key == "PK"
    error_message = "DynamoDB hash key is incorrect"
  }

  assert {
    condition     = aws_dynamodb_table.this[0].range_key == "SK"
    error_message = "DynamoDB range key is incorrect"
  }

  assert {
    condition     = aws_dynamodb_table.this[0].name == "test-dynamodb-table"
    error_message = "DynamoDB table name is incorrect"
  }
}

run "dynamodb_encryption" {
  command = plan

  assert {
    condition     = aws_dynamodb_table.this[0].server_side_encryption[0].enabled == true
    error_message = "DynamoDB encryption should be enabled"
  }
}

run "dynamodb_point_in_time_recovery" {
  command = plan

  assert {
    condition     = aws_dynamodb_table.this[0].point_in_time_recovery[0].enabled == true
    error_message = "DynamoDB point-in-time recovery should be enabled"
  }
}

run "dynamodb_ttl" {
  command = plan

  assert {
    condition     = aws_dynamodb_table.this[0].ttl[0].enabled == true
    error_message = "DynamoDB TTL should be enabled"
  }

  assert {
    condition     = aws_dynamodb_table.this[0].ttl[0].attribute_name == "Expires"
    error_message = "DynamoDB TTL attribute is incorrect"
  }
}

run "dynamodb_table_not_created_when_disabled" {
  variables {
    enable_datastore      = false
    create_dynamodb_table = false
  }

  command = plan

  assert {
    condition     = length(aws_dynamodb_table.this) == 0
    error_message = "DynamoDB table should not be created when disabled"
  }
}

run "dynamodb_global_secondary_index" {
  command = plan

  assert {
    condition     = length(aws_dynamodb_table.this[0].global_secondary_index) > 0
    error_message = "DynamoDB global secondary index should be created"
  }

  assert {
    condition     = length([for gsi in aws_dynamodb_table.this[0].global_secondary_index : gsi if gsi.name == "GSI1"]) > 0
    error_message = "DynamoDB GSI name is incorrect"
  }

  assert {
    condition     = length([for gsi in aws_dynamodb_table.this[0].global_secondary_index : gsi if gsi.hash_key == "GSI1PK"]) > 0
    error_message = "DynamoDB GSI hash key is incorrect"
  }

  assert {
    condition     = length([for gsi in aws_dynamodb_table.this[0].global_secondary_index : gsi if gsi.range_key == "GSI1SK"]) > 0
    error_message = "DynamoDB GSI range key is incorrect"
  }
}

run "dynamodb_local_secondary_index" {
  command = plan

  assert {
    condition     = length(aws_dynamodb_table.this[0].local_secondary_index) > 0
    error_message = "DynamoDB local secondary index should be created"
  }

  assert {
    condition     = length([for lsi in aws_dynamodb_table.this[0].local_secondary_index : lsi if lsi.name == "LSI1"]) > 0
    error_message = "DynamoDB LSI name is incorrect"
  }

  assert {
    condition     = length([for lsi in aws_dynamodb_table.this[0].local_secondary_index : lsi if lsi.range_key == "LSI1SK"]) > 0
    error_message = "DynamoDB LSI range key is incorrect"
  }
}


run "dynamodb_streams" {
  variables {
    dynamodb_enable_streams   = true
    dynamodb_stream_view_type = "NEW_AND_OLD_IMAGES"
  }

  command = plan

  assert {
    condition     = aws_dynamodb_table.this[0].stream_enabled == true
    error_message = "DynamoDB streams should be enabled"
  }

  assert {
    condition     = aws_dynamodb_table.this[0].stream_view_type == "NEW_AND_OLD_IMAGES"
    error_message = "DynamoDB stream view type is incorrect"
  }
}

run "dynamodb_iam_policy" {
  command = plan

  assert {
    condition     = length(aws_iam_policy.dynamodb_table_datastore) > 0
    error_message = "DynamoDB IAM policy should be created"
  }
}

run "dynamodb_autoscaling" {
  command = apply

  assert {
    condition     = length(module.dynamodb_autoscaler.aws_appautoscaling_target.read_target) > 0
    error_message = "DynamoDB read autoscaling target should be created"
  }

  assert {
    condition     = length(module.dynamodb_autoscaler.aws_appautoscaling_target.write_target) > 0
    error_message = "DynamoDB write autoscaling target should be created"
  }

  assert {
    condition     = length(module.dynamodb_autoscaler.aws_appautoscaling_policy.read_policy) > 0
    error_message = "DynamoDB read autoscaling policy should be created"
  }

  assert {
    condition     = length(module.dynamodb_autoscaler.aws_appautoscaling_policy.write_policy) > 0
    error_message = "DynamoDB write autoscaling policy should be created"
  }
}

run "dynamodb_streams_disabled" {
  variables {
    enable_datastore      = true
    create_dynamodb_table = true
    dynamodb_enable_streams = false
    dynamodb_stream_view_type = null
  }

  command = plan

  assert {
    condition     = aws_dynamodb_table.this[0].stream_enabled == false
    error_message = "DynamoDB streams should be disabled by default"
  }

  assert {
    condition     = aws_dynamodb_table.this[0].stream_view_type == ""
    error_message = "DynamoDB stream view type should be empty when streams are disabled"
  }
}
