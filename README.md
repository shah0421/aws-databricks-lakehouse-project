# Databricks S3 & Secrets Terraform Setup

This Terraform project automates the provisioning of AWS resources and Databricks integration for securely storing and accessing S3 data via Unity Catalog. It follows best practices for IAM, Secrets Manager, and storage credentials.

---

## Project Overview

This setup provisions:

1. **AWS S3 Bucket**
   - Bucket: `amzn-s3-gizmobox-project-bucket`
   - Region: `us-west-2`
   - Tagged for environment (`Dev`) and name.

2. **AWS Secrets Manager**
   - Secret: `db_secrets`
   - Stores Databricks credentials (`databricks_host` and `databricks_token`) securely.

3. **IAM Role for Databricks**
   - Role: `DatabricksS3AccessRole`
   - Policies attached:
     - `AccessDBSecrets` → allows retrieving Databricks secrets from Secrets Manager.
     - `DatabricksS3Access` → allows full access to S3 bucket objects.
   - Trust policy:
     - Self-assuming (required for Unity Catalog).
     - Databricks AWS account can assume the role.

4. **Databricks Storage Credential**
   - Connects Databricks Unity Catalog to the S3 bucket using the IAM role.

---

---

## Copying Files to S3

To upload or sync files to the provisioned S3 bucket, the AWS CLI can be used.

### ⚠️ About Authentication Used in This Project

While **best practice** is to use **AWS IAM roles** with permissions to write to the S3 bucket (avoiding long-lived credentials entirely), **for convenience in this setup we used local AWS credentials**.

Specifically:

- The `aws_access_key_id` and `aws_secret_access_key` from your **local AWS credentials file** (usually stored in `~/.aws/credentials`) were used to authenticate the AWS CLI when copying data into the S3 bucket.

This allows simple CLI-based copying but should be avoided in production environments.

## Examples

```bash
aws s3 sync ./data/Customers s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Customers
```