terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.30.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "terraform_aws"
}

// Fetch Databricks secrets from Secrets Manager
provider "databricks" {
  host  = local.databricks_secret["databricks_host"]
  token = local.databricks_secret["databricks_token"]
}
