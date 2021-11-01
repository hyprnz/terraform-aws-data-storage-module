## Terraform Datastore module
Provides an optional choice of data storage implementations in AWS. this module is designed to be used in a compute service module such as ECS or Kubernetes.

Currently supports

* No Datastore
* RDS (Postgres/MSSQL)
* S3
* Dynamodb

Branch `0.11` is compatible with `Terraform 0.11` but is no longer supported
---
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.31 |
| aws | >= 3.38.0 |
| null | >=2.1 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.38.0 |
| null | >=2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backup_retention_period | The backup retention period in days | `number` | `7` | no |
| create_dynamodb_table | Whether or not to enable DynamoDB resources | `bool` | `false` | no |
| create_rds_instance | Controls if an RDS instance should be provisioned. Will take precedence if this and `use_rds_snapshot` are both true. | `bool` | `false` | no |
| create_s3_bucket | Controls if an S3 bucket should be provisioned | `bool` | `false` | no |
| dynamodb_attributes | Additional DynamoDB attributes in the form of a list of mapped values | `list` | `[]` | no |
| dynamodb_autoscale_max_read_capacity | DynamoDB autoscaling max read capacity | `number` | `20` | no |
| dynamodb_autoscale_max_write_capacity | DynamoDB autoscaling max write capacity | `number` | `20` | no |
| dynamodb_autoscale_min_read_capacity | DynamoDB autoscaling min read capacity | `number` | `5` | no |
| dynamodb_autoscale_min_write_capacity | DynamoDB autoscaling min write capacity | `number` | `5` | no |
| dynamodb_autoscale_read_target | The target value (in %) for DynamoDB read autoscaling | `number` | `50` | no |
| dynamodb_autoscale_write_target | The target value (in %) for DynamoDB write autoscaling | `number` | `50` | no |
| dynamodb_billing_mode | DynamoDB Billing mode. Can be PROVISIONED or PAY_PER_REQUEST | `string` | `"PROVISIONED"` | no |
| dynamodb_enable_autoscaler | Whether or not to enable DynamoDB autoscaling | `bool` | `false` | no |
| dynamodb_enable_encryption | Enable DynamoDB server-side encryption | `bool` | `true` | no |
| dynamodb_enable_point_in_time_recovery | Enable DynamoDB point in time recovery | `bool` | `true` | no |
| dynamodb_enable_streams | Enable DynamoDB streams | `bool` | `false` | no |
| dynamodb_global_secondary_index_map | Additional global secondary indexes in the form of a list of mapped values | `any` | `[]` | no |
| dynamodb_hash_key | DynamoDB table Hash Key | `string` | `""` | no |
| dynamodb_hash_key_type | Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| dynamodb_local_secondary_index_map | Additional local secondary indexes in the form of a list of mapped values | `list` | `[]` | no |
| dynamodb_range_key | DynamoDB table Range Key | `string` | `""` | no |
| dynamodb_range_key_type | Range Key type, which must be a scalar type: `S`, `N` or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| dynamodb_stream_view_type | When an item in a table is modified, what information is written to the stream | `string` | `""` | no |
| dynamodb_table_name | DynamoDB table name. Must be supplied if creating a dynamodb table | `string` | `""` | no |
| dynamodb_tags | Additional tags (e.g map(`BusinessUnit`,`XYX`) | `map` | `{}` | no |
| dynamodb_ttl_attribute | DynamoDB table ttl attribute | `string` | `"Expires"` | no |
| dynamodb_ttl_enabled | Whether ttl is enabled or disabled | `bool` | `true` | no |
| enable_datastore | Enables the data store module that will provision data storage resources | `bool` | `true` | no |
| rds_allocated_storage | Amount of storage allocated to RDS instance | `number` | `10` | no |
| rds_apply_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window. Defaults to `false`. | `bool` | `false` | no |
| rds_auto_minor_version_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to `true`. | `bool` | `true` | no |
| rds_backup_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window | `string` | `"16:19-16:49"` | no |
| rds_database_name | Name of the database | `string` | `""` | no |
| rds_enable_deletion_protection | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The default is `false`. | `bool` | `false` | no |
| rds_enable_performance_insights | Controls the enabling of RDS Performance insights. Default to `true` | `bool` | `true` | no |
| rds_engine | The Database engine for the rds instance | `string` | `"postgres"` | no |
| rds_engine_version | The version of the database engine. | `number` | `11` | no |
| rds_final_snapshot_identifier | The name of your final DB snapshot when this DB instance is deleted. Must be provided if `rds_skip_final_snapshot` is set to false. The value must begin with a letter, only contain alphanumeric characters and hyphens, and not end with a hyphen or contain two consecutive hyphens. | `string` | `""` | no |
| rds_identifier | Identifier of datastore instance | `string` | `""` | no |
| rds_instance_class | The instance type to use | `string` | `"db.t3.small"` | no |
| rds_iops | The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' | `number` | `0` | no |
| rds_max_allocated_storage | The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to `allocated_storage`. Must be greater than or equal to `allocated_storage` or `0` to disable Storage Autoscaling. | `number` | `0` | no |
| rds_monitoring_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| rds_monitoring_role_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero. | `string` | `""` | no |
| rds_multi_az | Specifies if the RDS instance is multi-AZ. | `bool` | `false` | no |
| rds_option_group_name | Name of the DB option group to associate | `string` | `null` | no |
| rds_password | RDS database password for the user | `string` | `""` | no |
| rds_security_group_ids | A List of security groups to bind to the rds instance | `list(string)` | `[]` | no |
| rds_skip_final_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier | `bool` | `true` | no |
| rds_storage_encrypted | Specifies whether the DB instance is encrypted | `bool` | `false` | no |
| rds_storage_encryption_kms_key_arn | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| rds_subnet_group | Subnet group for RDS instances | `string` | `""` | no |
| rds_tags | Additional tags for rds datastore resources | `map` | `{}` | no |
| rds_username | RDS database user name | `string` | `""` | no |
| s3_bucket_name | The name of the bucket | `string` | `""` | no |
| s3_bucket_namespace | The namespace of the bucket - intention is to help avoid naming collisions | `string` | `""` | no |
| s3_enable_versioning | If versioning should be configured on the bucket | `bool` | `true` | no |
| s3_tags | Additional tags to be added to the s3 resources | `map` | `{}` | no |
| tags | Tags for all datastore resources | `map` | `{}` | no |
| use_rds_snapshot | Controls if an RDS snapshot should be used when creating the rds instance. Will use the latest snapshot of the `rds_identifier` variable. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb_global_secondary_index_names | DynamoDB secondary index names |
| dynamodb_local_secondary_index_names | DynamoDB local index names |
| dynamodb_table_arn | DynamoDB table ARN |
| dynamodb_table_id | DynamoDB table ID |
| dynamodb_table_name | DynamoDB table name |
| dynamodb_table_policy_arn | Policy arn to be attached to an execution role defined in the parent module. |
| dynamodb_table_stream_arn | DynamoDB table stream ARN |
| dynamodb_table_stream_label | DynamoDB table stream label |
| rds_db_name | The name of the rds database |
| rds_db_url | The connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name` |
| rds_db_url_encoded | The connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name` |
| rds_db_user | The RDS db username |
| rds_engine_version | The actual engine version used by the RDS instance. |
| rds_instance_address | The address of the RDS instance |
| rds_instance_arn | The ARN of the RDS instance |
| rds_instance_endpoint | The connection endpoint |
| rds_instance_id | The RDS instance ID |
| s3_bucket | The name of the bucket |
| s3_bucket_policy_arn | Policy arn to be attached to a execution role defined in the parent module |

<br/>

---
## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```
Copyright 2020 Hypr NZ

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

Copyright &copy; 2020 [Hypr NZ](https://www.hypr.nz/)
<!-- END_TF_DOCS -->
