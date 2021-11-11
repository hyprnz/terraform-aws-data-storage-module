resource "aws_s3_bucket" "this" {
  count = local.count_s3

  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = var.s3_enable_versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = merge(var.s3_tags, var.tags)
}

