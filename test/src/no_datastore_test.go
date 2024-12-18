package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestNoDatastoreExample(t *testing.T) {
    t.Parallel()

    // Setup the Terraform options for the no_datastore example
    terraformOptions := &terraform.Options{
        // Path to the "no_datastore" example directory
        TerraformDir: "../../examples/no_datastore",

        // Variables specific to this example can be passed here
        Vars: map[string]interface{}{
            "enable_datastore": false,
        },
    }

    // At the end of the test, destroy the Terraform resources
    defer terraform.Destroy(t, terraformOptions)

    // Init and apply the Terraform configuration
    terraform.InitAndApply(t, terraformOptions)

    // Outputs: there should be no datastore resources
    dynamodbTable := terraform.Output(t, terraformOptions, "db_name")
    rdsInstance := terraform.Output(t, terraformOptions, "ddb_table_name")
    s3Bucket := terraform.Output(t, terraformOptions, "s3_bucket_name")

    // Assert that no DynamoDB table, RDS instance, or S3 bucket was created
    assert.Empty(t, dynamodbTable, "No DynamoDB table should be created")
    assert.Empty(t, rdsInstance, "No RDS instance should be created")
    assert.Empty(t, s3Bucket, "No S3 bucket should be created")
}
