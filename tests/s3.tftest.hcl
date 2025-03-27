provider "aws" {
  region = "us-west-2"
}

variables {
  enable_datastore = true
  create_s3_bucket = true
  s3_bucket_name   = "my-datastore-example-bucket"
  tags = {
    Environment = "test"
    ManagedBy   = "Terraform"
  }
  s3_tags = {
    BucketPurpose = "testing"
  }
}

run "test_locals" {
  assert {
    condition     = local.create_s3 == true
    error_message = "local.create_s3 should be true when both enable_datastore and create_s3_bucket are true."
  }

  assert {
    condition     = local.count_s3 == 1
    error_message = "local.count_s3 should be 1 when create_s3_bucket is true."
  }

  assert {
    condition     = local.create_s3 == (var.enable_datastore && var.create_s3_bucket)
    error_message = "local.create_s3 should be the logical AND of enable_datastore and create_s3_bucket."
  }
}

run "s3_bucket_creation" {
  assert {
    condition     = length(aws_s3_bucket.this) > 0
    error_message = "S3 bucket was not created."
  }

  assert {
    condition     = aws_s3_bucket.this[0].bucket == var.s3_bucket_name
    error_message = "S3 bucket name does not match the configured variable."
  }

  assert {
    condition     = length(aws_s3_bucket.this[0].tags) > 0
    error_message = "S3 bucket should have tags applied."
  }
}

run "s3_bucket_not_created_when_disabled" {
  variables {
    enable_datastore = false
    create_s3_bucket = false
  }

  assert {
    condition     = length(aws_s3_bucket.this) == 0
    error_message = "S3 bucket should not be created when both enable_datastore and create_s3_bucket are false."
  }
}

run "s3_bucket_not_created_when_s3_disabled" {
  variables {
    enable_datastore = true
    create_s3_bucket = false
  }

  assert {
    condition     = length(aws_s3_bucket.this) == 0
    error_message = "S3 bucket should not be created when create_s3_bucket is false."
  }
}

run "s3_bucket_not_created_when_datastore_disabled" {
  variables {
    enable_datastore = false
    create_s3_bucket = true
  }

  assert {
    condition     = length(aws_s3_bucket.this) == 0
    error_message = "S3 bucket should not be created when both enable_datastore is false."
  }
}

run "s3_ownership_control" {

  assert {
    condition     = aws_s3_bucket_ownership_controls.this[0].rule[0].object_ownership == "BucketOwnerPreferred"
    error_message = "S3 bucket ownership control is not set to 'BucketOwnerPreferred'."
  }
}

run "s3_versioning" {
  variables {
    s3_enable_versioning = true
  }
  assert {
    condition     = aws_s3_bucket_versioning.this[0].versioning_configuration[0].status == "Enabled"
    error_message = "S3 bucket versioning is not enabled."
  }
}

run "s3_encryption" {
  assert {
    condition     = length([for rule in aws_s3_bucket_server_side_encryption_configuration.this[0].rule : rule.apply_server_side_encryption_by_default[0].sse_algorithm == "aws:kms"]) > 0
    error_message = "S3 bucket encryption is not set to AWS KMS."
  }
}

run "s3_iam_policy" {
  assert {
    condition     = length(aws_iam_policy.s3_datastore_bucket) > 0
    error_message = "IAM policy for S3 bucket was not created."
  }
}

run "s3_bucket_acl" {
  assert {
    condition     = length(aws_s3_bucket_acl.this) > 0
    error_message = "S3 bucket ACL was not configured."
  }
}

run "s3_bucket_tags" {
  assert {
    condition     = lookup(aws_s3_bucket.this[0].tags, "Environment") == "test"
    error_message = "S3 bucket should have Environment tag."
  }

  assert {
    condition     = lookup(aws_s3_bucket.this[0].tags, "ManagedBy") == "Terraform"
    error_message = "S3 bucket should have ManagedBy tag."
  }

  assert {
    condition     = lookup(aws_s3_bucket.this[0].tags, "BucketPurpose") == "testing"
    error_message = "S3 bucket should have BucketPurpose tag."
  }
}

run "s3_bucket_region" {
  assert {
    condition     = aws_s3_bucket.this[0].region == "us-west-2"
    error_message = "S3 bucket region should match provider region."
  }
}
