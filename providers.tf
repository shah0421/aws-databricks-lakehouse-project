terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.30.0" # or latest
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "terraform_aws" # OR your profile name
}


provider "databricks" {
  host  = local.databricks_secret["databricks_host"]
  token = local.databricks_secret["databricks_token"]
}
