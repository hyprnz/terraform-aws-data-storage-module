locals {
  count_ddb_table_policy = local.create_dynamodb && !var.dynamodb_enable_streams ? 1 : 0

  count_ddb_table_and_stream_policy = local.create_dynamodb && var.dynamodb_enable_streams ? 1 : 0

  dynamodb_table_iam_actions = [
    "dynamodb:DescribeTable",
    "dynamodb:BatchGetItem",
    "dynamodb:GetItem",
    "dynamodb:Query",
    "dynamodb:Scan",
    "dynamodb:BatchWriteItem",
    "dynamodb:PutItem",
    "dynamodb:DeleteItem",
    "dynamodb:UpdateItem"
  ]
}

data "aws_iam_policy_document" "dynamodb_table_datastore" {
  count = local.count_ddb_table_policy

  statement {
    sid = "DataStorageDynamodbActions"

    effect = "Allow"

    actions = local.dynamodb_table_iam_actions

    resources = [
      aws_dynamodb_table.this[0].arn,
      "${aws_dynamodb_table.this[0].arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "dynamodb_table_stream_datastore" {
  count = local.count_ddb_table_and_stream_policy

  statement {
    sid = "DataStorageDynamodbActions"

    effect = "Allow"

    actions = local.dynamodb_table_iam_actions

    resources = [
      aws_dynamodb_table.this[0].arn,
      "${aws_dynamodb_table.this[0].arn}/*"
    ]
  }

  statement {
    sid = "DataStorageDynamodbStreamActions"

    effect = "Allow"

    actions = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]

    resources = [
      "${aws_dynamodb_table.this[0].arn}/stream/*"
    ]
  }
}



resource "aws_iam_policy" "dynamodb_table_datastore" {
  count = local.count_dynamodb

  name        = "${var.dynamodb_table_name}-DS-ddb"
  policy      = local.count_ddb_table_and_stream_policy == 1 ? data.aws_iam_policy_document.dynamodb_table_stream_datastore[0].json : data.aws_iam_policy_document.dynamodb_table_datastore[0].json
  path        = var.iam_resource_path
  description = "Grants permissions to access the dynamodb table and associated objects"
}
