
locals {

  enable_autoscaler = local.create_dynamodb && var.dynamodb_enable_autoscaler
  create_autoscaler = local.enable_autoscaler && var.dynamodb_billing_mode == "PROVISIONED"

  attributes_composed = [
    {
      name = var.dynamodb_range_key
      type = var.dynamodb_range_key_type
    },
    {
      name = var.dynamodb_hash_key
      type = var.dynamodb_hash_key_type
    },
  ]

  attributes_combined = concat(local.attributes_composed, var.dynamodb_attributes)

  # Use the `slice` pattern (instead of `conditional`) to remove the first map
  # from the list if no `range_key` is provided
  # Terraform does not support conditionals with `lists` and `maps`:
  # aws_dynamodb_table.default : conditional operator cannot be used with list values
  #
  from_index = length(var.dynamodb_range_key) > 0 ? 0 : 1

  attributes_final = slice(local.attributes_combined, local.from_index, length(local.attributes_combined))
}

resource "null_resource" "global_secondary_index_names" {
  count = (local.create_dynamodb ? 1 : 0) * length(var.dynamodb_global_secondary_index_map)
  # Convert the multi-item `global_secondary_index_map` into a simple `map`
  # with just one item `name` since `triggers` does not support `lists` in
  # `maps` (which are used in `non_key_attributes`)
  # https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#non_key_attributes-1
  triggers = map("name", lookup(var.dynamodb_global_secondary_index_map[count.index], "name"))
}

resource "null_resource" "local_secondary_index_names" {
  count = (local.create_dynamodb ? 1 : 0) * length(var.dynamodb_local_secondary_index_map)
  # Convert the multi-item `local_secondary_index_map` into a simple `map`
  # with just one item `name` since `triggers` does not support `lists` in
  # `maps` (which are used in `non_key_attributes`)
  # https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#non_key_attributes-1
  triggers = map("name", lookup(var.dynamodb_local_secondary_index_map[count.index], "name"))
}

resource "aws_dynamodb_table" "this" {
  count            = local.create_dynamodb ? 1 : 0
  name             = var.dynamodb_table_name
  billing_mode     = var.dynamodb_billing_mode
  read_capacity    = var.dynamodb_autoscale_min_read_capacity
  write_capacity   = var.dynamodb_autoscale_min_write_capacity
  hash_key         = var.dynamodb_hash_key
  range_key        = var.dynamodb_range_key
  stream_enabled   = var.dynamodb_enable_streams
  stream_view_type = var.dynamodb_enable_streams ? var.dynamodb_stream_view_type : ""

  dynamic "global_secondary_index" {
    for_each = var.dynamodb_global_secondary_index_map
    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.dynamodb_local_secondary_index_map
    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = local_secondary_index.value.range_key
    }
  }

  dynamic "attribute" {
    for_each = local.attributes_final

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  server_side_encryption {
    enabled = var.dynamodb_enable_encryption
  }

  ttl {
    enabled        = var.dynamodb_ttl_enabled
    attribute_name = var.dynamodb_ttl_attribute
  }

  point_in_time_recovery {
    enabled = var.dynamodb_enable_point_in_time_recovery
  }

  lifecycle {
    ignore_changes = [read_capacity, write_capacity]
  }

  tags = merge(map("Name", var.dynamodb_table_name), var.dynamodb_tags, var.tags)
}

module "dynamodb_autoscaler" {
  source                       = "./modules/dynamodb_autoscaler"
  enabled                      = local.create_autoscaler
  dynamodb_table_name          = join(",", aws_dynamodb_table.this[*].name)
  dynamodb_table_arn           = join(",", aws_dynamodb_table.this[*].arn)
  dynamodb_indexes             = null_resource.global_secondary_index_names[*].triggers.name
  autoscale_read_target        = var.dynamodb_autoscale_read_target
  autoscale_write_target       = var.dynamodb_autoscale_write_target
  autoscale_min_read_capacity  = var.dynamodb_autoscale_min_read_capacity
  autoscale_max_read_capacity  = var.dynamodb_autoscale_max_read_capacity
  autoscale_min_write_capacity = var.dynamodb_autoscale_min_write_capacity
  autoscale_max_write_capacity = var.dynamodb_autoscale_max_write_capacity
}
