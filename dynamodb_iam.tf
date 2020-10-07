data "aws_iam_policy_document" "dynamodb_table_datastore" {
  count = local.create_dynamodb ? 1 : 0

  statement {
    sid = "DynamodbDataStore${replace(title(var.dynamodb_table_name), "/-| /", "")}Actions"

    effect = "Allow"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      join("", aws_dynamodb_table.this[*].arn)
    ]
  }

    statement {
    sid = "DynamodbDataStore${replace(title(var.dynamodb_table_name), "/-| /", "")}StreamActions"

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
  count = local.create_dynamodb ? 1 : 0

  name        = "DynamodbDataStoreTableAccess${replace(title(var.dynamodb_table_name), "/-| /", "")}Policy"
  policy      = data.aws_iam_policy_document.dynamodb_table_datastore[0].json
  description = "Grants permissions to access the dynamodb table and associated objects"
}
