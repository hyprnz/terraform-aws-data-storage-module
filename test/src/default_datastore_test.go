package test

import (
    "testing"

    awsSDK "github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/gruntwork-io/terratest/modules/aws"
    "github.com/stretchr/testify/assert"
)

// Test the DynamoDB example
func TestDefaultDatastoreExample(t *testing.T) {
    t.Parallel()

    awsRegion := "us-west-2"

    expectedKmsKeyArn := aws.GetCmkArn(t, awsRegion, "alias/aws/dynamodb")
	expectedKeySchema := []types.KeySchemaElement{
		{AttributeName: awsSDK.String("PK"), KeyType: types.KeyTypeHash},
		{AttributeName: awsSDK.String("SK"), KeyType: types.KeyTypeRange},
    }

    // Configure Terraform options for the DynamoDB example
    terraformOptions := &terraform.Options{
        // The path to where the DynamoDB example is located
        TerraformDir: "../../examples/default",

        // Variables to pass to the Terraform module
        Vars: map[string]interface{}{
            "dynamodb_table_name": "hypr-env-example",
            "dynamodb_hash_key": "PK",
            "dynamodb_hash_key_type": "S",
            "dynamodb_range_key": "SK",
            "dynamodb_range_key_type": "S",
            "dynamodb_billing_mode": "PAY_PER_REQUEST",
            "dynamodb_enable_encryption": false,
            "dynamodb_enable_point_in_time_recovery": true,
            "dynamodb_ttl_enabled": true,
            "dynamodb_ttl_attribute": "Expires",
            "dynamodb_enable_insights": true,
            "region": awsRegion,
        },
    }

    // Clean up resources at the end of the test
    defer terraform.Destroy(t, terraformOptions)

    // Initialize and apply Terraform configuration
    terraform.InitAndApply(t, terraformOptions)

    // Get the output of the DynamoDB table name from the Terraform module
    dynamodbTableName := terraform.Output(t, terraformOptions, "dynamodb_table_name")
    dynamodbTableArn := terraform.Output(t, terraformOptions, "dynamodb_table_arn")
    dynamodbTableId := terraform.Output(t, terraformOptions, "dynamodb_table_id")

    // Check if DynamoDB table is created successfully
    assert.NotEmpty(t, dynamodbTableName, "DynamoDB table name should not be empty")
    assert.NotEmpty(t, dynamodbTableArn, "DynamoDB table arn should not be empty")
    assert.NotEmpty(t, dynamodbTableId, "DynamoDB table id should not be empty")

    // Look up the DynamoDB table by name
    table := aws.GetDynamoDBTable(t, awsRegion, dynamodbTableName)

    // Validate the table
    assert.Equal(t, "hypr-env-example", awsSDK.ToString(table.TableName), "Expected table name to match the Terraform configuration")
    assert.Equal(t, "ACTIVE", string(table.TableStatus), "Expected table status to be ACTIVE")
	assert.ElementsMatch(t, expectedKeySchema, table.KeySchema, "Expected KeySchema to match expectedKeySchema")

    // Verify server-side encryption configuration
	assert.Equal(t, expectedKmsKeyArn, awsSDK.ToString(table.SSEDescription.KMSMasterKeyArn), "Expected KMS key ARN to match")
	assert.Equal(t, "ENABLED", string(table.SSEDescription.Status), "Expected SSE to be ENABLED")
	assert.Equal(t, "KMS", string(table.SSEDescription.SSEType), "Expected SSE Type to eb KMS")
}
