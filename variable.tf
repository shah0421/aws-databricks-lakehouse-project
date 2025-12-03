variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "databricks_host" {
  type        = string
  description = "Databricks workspace URL (can be fetched from secret)"
}

variable "s3_bucket_name" {
  type    = string
  default = "amzn-s3-gizmobox-project-bucket"
}

variable "databricks_secret_name" {
  type        = string
  description = "Name of the secret in Secrets Manager"
  default     = "db_secrets"
}

variable "external_account_id" {
  type        = string
  description = "External Databricks AWS account ID allowed to assume this role"
  default     = "414351767826"
}

variable "own_account_id" {
  type        = string
  description = "AWS account ID where the role is created"
  default     = "861185453721"
}


