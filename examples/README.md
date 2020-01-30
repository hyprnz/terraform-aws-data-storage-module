# Examples
Examples of how to use this module.

* [No Datasource](./no_datastore) - Configured to use the module, but not create any resources
* [RDS](./rds) - Configured to create a PostgreSQL instance using the module
* [S3](./s3) - Configured to create an S3 bucket

# Running the Examples
The examples are configured to be run in the `ap-southeast-2` AWS region. To
change this when running an example you will need to update the `my_region`
variable in the `vars.tf` file.

### vars.tf
```
variable "my_region" {
  description = "AWS region where example resources will be created"
  default     = "ap-southeast-2"
}
```
