resource "aws_s3_bucket" "this" {
  count = local.count_s3

  bucket = var.s3_bucket_name

  tags = merge(var.s3_tags, var.tags)
}

resource "aws_s3_bucket_acl" "this" {
  count = local.count_s3

  bucket = aws_s3_bucket.this[0].id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count = local.count_s3

  bucket = aws_s3_bucket.this[0].id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  count = local.count_s3

  bucket = aws_s3_bucket.this[0].id
  versioning_configuration {
    status = var.s3_enable_versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = local.count_s3

  bucket = aws_s3_bucket.this[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}