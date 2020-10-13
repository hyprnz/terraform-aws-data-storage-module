## Terraform Datastore module
Provides an optional choice of data storage implementations in AWS. this module is designed to be used in a compute service module such as ECS or Kubernetes.

Currently supports

* No Datastore
* RDS (Postgres/MSSQL)
* S3

Branch `0.11` is compatible with `Terraform 0.11`

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| null | ~> 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| backup\_retention\_period | The backup retention period in days | `number` | `7` | no |
| create\_dynamodb\_table | Whether or not to enable DynamoDB resources | `bool` | `false` | no |
| create\_rds\_instance | Controls if an RDS instance should be provisioned. | `bool` | `false` | no |
| create\_s3\_bucket | Controls if an S3 bucket should be provisioned | `bool` | `false` | no |
| dynamodb\_attributes | Additional DynamoDB attributes in the form of a list of mapped values | `list` | `[]` | no |
| dynamodb\_autoscale\_max\_read\_capacity | DynamoDB autoscaling max read capacity | `number` | `20` | no |
| dynamodb\_autoscale\_max\_write\_capacity | DynamoDB autoscaling max write capacity | `number` | `20` | no |
| dynamodb\_autoscale\_min\_read\_capacity | DynamoDB autoscaling min read capacity | `number` | `5` | no |
| dynamodb\_autoscale\_min\_write\_capacity | DynamoDB autoscaling min write capacity | `number` | `5` | no |
| dynamodb\_autoscale\_read\_target | The target value (in %) for DynamoDB read autoscaling | `number` | `50` | no |
| dynamodb\_autoscale\_write\_target | The target value (in %) for DynamoDB write autoscaling | `number` | `50` | no |
| dynamodb\_billing\_mode | DynamoDB Billing mode. Can be PROVISIONED or PAY\_PER\_REQUEST | `string` | `"PROVISIONED"` | no |
| dynamodb\_enable\_autoscaler | Whether or not to enable DynamoDB autoscaling | `bool` | `false` | no |
| dynamodb\_enable\_encryption | Enable DynamoDB server-side encryption | `bool` | `true` | no |
| dynamodb\_enable\_point\_in\_time\_recovery | Enable DynamoDB point in time recovery | `bool` | `true` | no |
| dynamodb\_enable\_streams | Enable DynamoDB streams | `bool` | `false` | no |
| dynamodb\_global\_secondary\_index\_map | Additional global secondary indexes in the form of a list of mapped values | `any` | `[]` | no |
| dynamodb\_hash\_key | DynamoDB table Hash Key | `string` | `""` | no |
| dynamodb\_hash\_key\_type | Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| dynamodb\_local\_secondary\_index\_map | Additional local secondary indexes in the form of a list of mapped values | `list` | `[]` | no |
| dynamodb\_range\_key | DynamoDB table Range Key | `string` | `""` | no |
| dynamodb\_range\_key\_type | Range Key type, which must be a scalar type: `S`, `N` or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| dynamodb\_stream\_view\_type | When an item in a table is modified, what information is written to the stream | `string` | `""` | no |
| dynamodb\_table\_name | DynamoDB table name. Must be supplied if creating a dynamodb table | `string` | `""` | no |
| dynamodb\_tags | Additional tags (e.g map(`BusinessUnit`,`XYX`) | `map` | `{}` | no |
| dynamodb\_ttl\_attribute | DynamoDB table ttl attribute | `string` | `"Expires"` | no |
| dynamodb\_ttl\_enabled | Whether ttl is enabled or disabled | `bool` | `true` | no |
| enable\_datastore | Enables the data store module that will provision data storage resources | `bool` | `true` | no |
| rds\_allocated\_storage | Amount of storage allocated to RDS instance | `number` | `10` | no |
| rds\_backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | `"16:19-16:49"` | no |
| rds\_database\_name | Name of the database | `string` | `""` | no |
| rds\_enable\_performance\_insights | Controls the enabling of RDS Performance insights. Default to `true` | `bool` | `true` | no |
| rds\_engine | The Database engine for the rds instance | `string` | `"postgres"` | no |
| rds\_engine\_version | The version of the database engine. | `number` | `11.4` | no |
| rds\_identifier | Identifier of datastore instance | `string` | `""` | no |
| rds\_instance\_class | The instance type to use | `string` | `"db.t3.small"` | no |
| rds\_iops | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' | `number` | `0` | no |
| rds\_max\_allocated\_storage | The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to `allocated_storage`. Must be greater than or equal to `allocated_storage` or `0` to disable Storage Autoscaling. | `number` | `0` | no |
| rds\_monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| rds\_monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `""` | no |
| rds\_option\_group\_name | Name of the DB option group to associate | `string` | n/a | yes |
| rds\_password | RDS database password for the user | `string` | `""` | no |
| rds\_security\_group\_ids | A List of security groups to bind to the rds instance | `list(string)` | `[]` | no |
| rds\_skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| rds\_storage\_encrypted | Specifies whether the DB instance is encrypted | `bool` | `false` | no |
| rds\_storage\_encryption\_kms\_key\_arn | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| rds\_subnet\_group | Subnet group for RDS instances | `string` | `""` | no |
| rds\_tags | Additional tags for rds datastore resources | `map` | `{}` | no |
| rds\_username | RDS database user name | `string` | `""` | no |
| s3\_bucket\_name | The name of the bucket | `string` | `""` | no |
| s3\_bucket\_namespace | The namespace of the bucket - intention is to help avoid naming collisions | `string` | `""` | no |
| s3\_enable\_versioning | If versioning should be configured on the bucket | `bool` | `true` | no |
| s3\_tags | Additional tags to be added to the s3 resources | `map` | `{}` | no |
| tags | Tags for all datastore resources | `map` | `{}` | no |
| use\_rds\_snapshot | Controls if an RDS snapshot should be used. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb\_global\_secondary\_index\_names | DynamoDB secondary index names |
| dynamodb\_local\_secondary\_index\_names | DynamoDB local index names |
| dynamodb\_table\_arn | DynamoDB table ARN |
| dynamodb\_table\_id | DynamoDB table ID |
| dynamodb\_table\_name | DynamoDB table name |
| dynamodb\_table\_policy\_arn | Policy arn to be attached to an execution role defined in the parent module. |
| dynamodb\_table\_stream\_arn | DynamoDB table stream ARN |
| dynamodb\_table\_stream\_label | DynamoDB table stream label |
| rds\_db\_name | The name of the rds database |
| rds\_db\_url | The connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name` |
| rds\_db\_user | The RDS db username |
| rds\_instance\_address | The address of the RDS instance |
| rds\_instance\_arn | The ARN of the RDS instance |
| rds\_instance\_endpoint | The connection endpoint |
| rds\_instance\_id | The RDS instance ID |
| s3\_bucket | The name of the bucket |
| s3\_bucket\_policy\_arn | Policy arn to be attached to a execution role defined in the parent module |

