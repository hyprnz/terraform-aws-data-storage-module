data "aws_iam_policy_document" "s3_datastore_bucket" {
  count = "${local.create_s3}"

  statement {
    sid = "S3DatastoreBucket${replace(title(var.name),"/-| /","")}Actions"

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
      "arn:aws:s3:::${aws_s3_bucket.this.bucket}",
    ]
  }

  statement {
    sid = "S3DatastoreBucketObject${replace(title(var.name),"/-| /","")}Actions"

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
      "arn:aws:s3:::${aws_s3_bucket.this.bucket}/*",
    ]
  }
}

resource "aws_iam_policy" "s3_datastore_bucket" {
  count = "${local.create_s3}"

  name        = "S3BucketObjectAccess${replace(title(var.name),"/-| /","")}Policy"
  policy      = "${data.aws_iam_policy_document.s3_datastore_bucket.json}"
  description = "Grants permissions to access the bucket and associated objects in S3 bucket"
}

resource "aws_iam_role_policy_attachment" "s3_datastore_bucket" {
  count = "${local.create_s3}"

  role       = "${aws_iam_role.s3_datastore_bucket.name}"
  policy_arn = "${aws_iam_policy.s3_datastore_bucket.arn}"
}

resource "aws_iam_role" "s3_datastore_bucket" {
  count = "${local.create_s3}"

  name        = "k8s-S3BucketAccess${replace(title(var.name),"/-| /","")}Role"
  description = "Role Assumption policy for S3 bucket access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${var.s3_bucket_K8s_worker_iam_role_arn}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
