terraform {
  required_version = ">= 0.12.31"

  required_providers {
    aws = {
      source : "hashicorp/aws",
      version : ">= 5.26.0"
    }
    null = {
      source : "hashicorp/null",
      version : ">=2.1"
    }
  }
}
