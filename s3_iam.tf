data "aws_iam_policy_document" "s3_datastore_bucket" {
  count = local.create_s3

  statement {
    sid = "S3DatastoreBucket${replace(title(var.s3_bucket_name), "/-| |_/", "")}Actions"

    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketNotification",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this[0].bucket}",
    ]
  }

  statement {
    sid = "S3DatastoreBucketObject${replace(title(var.s3_bucket_name), "/-| |_/", "")}Actions"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:DeleteObjectTagging",
      "s3:DeleteObjectVersionTagging",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:ReplicateTags",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:PutBucketNotification",
      "s3:PutObject",
      "s3:RestoreObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this[0].bucket}/*",
    ]
  }
}

resource "aws_iam_policy" "s3_datastore_bucket" {
  count = local.create_s3

  name        = "S3DatstoreBucketObjectAccess${replace(title(var.s3_bucket_name), "/-| |_/", "")}Policy"
  policy      = data.aws_iam_policy_document.s3_datastore_bucket[0].json
  description = "Grants permissions to access the datastore bucket and associated objects"
}
