terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source : "hashicorp/aws",
      version : ">= 5.26.0, <6.0.0"
    }
    null = {
      source : "hashicorp/null",
      version : ">=2.1"
    }
  }
}
