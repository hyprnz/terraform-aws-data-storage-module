## Terraform Datastore module
Provides an optional choice of data storage implementations in AWS. this module is designed to be used in a compute service module such as ECS or Kubernetes.

Currently supports

* No Datastore
* RDS (Postgres)
* S3


Branch `0.11` is compatible with `Terraform 0.11`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| backup\_retention\_period | The backup retention period in days | string | `"7"` | no |
| create\_rds\_instance | Controls if an RDS instance should be provisioned. | string | `"false"` | no |
| create\_s3\_bucket | Controls if an S3 bucket should be provisioned | string | `"false"` | no |
| enable\_datastore | Enables the data store module that will provision data storage resources | string | `"true"` | no |
| name | Name of datastore instance | string | `""` | no |
| rds\_allocated\_storage | Amount of storage allocated to RDS instance | string | `"10"` | no |
| rds\_backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window | string | `"16:19-16:49"` | no |
| rds\_engine | The Database engine for the rds instance | string | `"postgres"` | no |
| rds\_engine\_version | The version of the database engine. | string | `"11.4"` | no |
| rds\_identifier | Identifier of datastore instance | string | `""` | no |
| rds\_instance\_class | The instance type to use | string | `"db.t3.small"` | no |
| rds\_iops | The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' | string | `"0"` | no |
| rds\_monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | string | `"0"` | no |
| rds\_monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero. | string | `""` | no |
| rds\_password | RDS database password for the user | string | `""` | no |
| rds\_security\_group\_ids | A List of security groups to bind to the rds instance | list | `<list>` | no |
| rds\_skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier | string | `"true"` | no |
| rds\_storage\_encrypted | Specifies whether the DB instance is encrypted | string | `"false"` | no |
| rds\_storage\_encryption\_kms\_key\_arn | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used | string | `""` | no |
| rds\_subnet\_group | Subnet group for RDS instances | string | `""` | no |
| rds\_tags | Additional tags for rds datastore resources | map | `<map>` | no |
| s3\_bucket\_K8s\_worker\_iam\_role\_arn | The arn of the Kubernetes worker role that allows a service to assume the role to access the bucket and options | string | `""` | no |
| s3\_bucket\_namespace | The namespace of the bucket - intention is to help avoid naming collisions | string | `""` | no |
| s3\_enable\_versioning | If versioning should be configured on the bucket | string | `"true"` | no |
| s3\_tags | Additional tags to be added to the s3 resources | map | `<map>` | no |
| tags | Tags for all datastore resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| rds\_db\_name | The name of the rds database |
| rds\_db\_url | The connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name` |
| rds\_db\_user | The RDS db username |
| rds\_instance\_address | The address of the RDS instance |
| rds\_instance\_arn | The ARN of the RDS instance |
| rds\_instance\_endpoint | The connection endpoint |
| rds\_instance\_id | The RDS instance ID |
| s3\_bucket | The name of the bucket |
| s3\_bucket\_role\_name | The name of the IAm role with access policy |

