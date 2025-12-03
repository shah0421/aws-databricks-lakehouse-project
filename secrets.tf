# Look up the secret by NAME
data "aws_secretsmanager_secret" "databricks" {
  name = var.databricks_secret_name
}

# Look up the latest secret value
data "aws_secretsmanager_secret_version" "databricks_version" {
  secret_id = data.aws_secretsmanager_secret.databricks.id
}

# Decode JSON string inside the secret
locals {
  databricks_secret_json = jsondecode(
    data.aws_secretsmanager_secret_version.databricks_version.secret_string
  )
}

