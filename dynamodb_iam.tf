data "aws_iam_policy_document" "dynamodb_table_datastore" {
  count = local.count_dynamodb

  statement {
    sid = "DataStorageDynamodbActions"

    effect = "Allow"

    actions = [
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

    resources = [
      join("", aws_dynamodb_table.this[*].arn),
      "${join("", aws_dynamodb_table.this[*].arn)}/*"
    ]
  }

  statement {
    sid = "DataStorageDynamodbStreamActions"

    effect = "Allow"

    actions = [
      "dynamodb:GetRecords"
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${join("", aws_dynamodb_table.this[*].name)}/stream/*"
    ]
  }
}



resource "aws_iam_policy" "dynamodb_table_datastore" {
  count = local.count_dynamodb

  name        = "DataStorage-Dynamodb-${replace(var.dynamodb_table_name, "/\\.| /", "")}-Policy"
  policy      = data.aws_iam_policy_document.dynamodb_table_datastore[0].json
  path        = var.iam_resource_path
  description = "Grants permissions to access the dynamodb table and associated objects"
}
