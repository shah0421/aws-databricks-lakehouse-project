# # Create terraform module with required providers as aws version 5.0. 
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "5.0.0"
#     }
#   }
# }

# # Configure the aws provider with region us-east-1 with link to credential file
# provider "aws" {
#   region                   = "us-west-2"
#   shared_credentials_files = ["~/.aws/credentials"]
#   profile                  = "terraform_aws"
#   assume_role {
#     role_arn     = "arn:aws:iam::861185453721:role/terraform_execution"
#     session_name = "terraform-session"
#   }
# }

# # Configure the Databricks provider
# provider "databricks" {
#   host  = var.databricks_host       # e.g., https://<workspace-url>
#   token = var.databricks_token      # personal access token
# }

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
