# IAM Role
resource "aws_iam_role" "databricks_s3_access_role" {
  name = "DatabricksS3AccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.external_account_id}:root",
            "arn:aws:iam::${var.own_account_id}:role/DatabricksS3AccessRole"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# Secrets access policy
resource "aws_iam_policy" "access_db_secrets" {
  name = "AccessDBSecrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = data.aws_secretsmanager_secret.databricks.arn
      }
    ]
  })
}


# S3 access policy
resource "aws_iam_policy" "databricks_s3_access" {
  name = "DatabricksS3Access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::${var.s3_bucket_name}"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  })
}

# Attach policies to the role
resource "aws_iam_role_policy_attachment" "attach_db_secrets_policy" {
  role       = aws_iam_role.databricks_s3_access_role.name
  policy_arn = aws_iam_policy.access_db_secrets.arn
  depends_on = [aws_iam_policy.access_db_secrets]
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.databricks_s3_access_role.name
  policy_arn = aws_iam_policy.databricks_s3_access.arn
  depends_on = [aws_iam_policy.databricks_s3_access]
}