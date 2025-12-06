# 📘 AWS Databricks Lakehouse & Streaming Ingestion Projects

This repository contains two comprehensive Databricks projects designed to demonstrate modern data engineering patterns on AWS. The first project showcases a full Lakehouse architecture built using Terraform, implementing the Medallion (Bronze–Silver–Gold) design, Unity Catalog governance, and automated ingestion pipelines from multiple data sources. The second project focuses specifically on streaming data ingestion, comparing traditional Spark Structured Streaming with Databricks Auto Loader, and demonstrating scalable, schema-aware ingestion of cloud file streams into Delta Lake. Together, these projects provide a complete view of batch + streaming data pipelines, cloud integration, and Lakehouse best practices.

# 📘 AWS Databricks Lakehouse Project  
## Medallion Architecture + Terraform Infrastructure

This project demonstrates an end-to-end **AWS Databricks Lakehouse** implementation, including:

- Automated infrastructure provisioning using **Terraform**
- Ingesting data from **multiple sources & formats**
- Applying the **Medallion Architecture** (Bronze → Silver → Gold)
- Building analytics-ready **Gold Layer** tables for BI & ML
- Integration with **S3, IAM, Secrets Manager, JDBC**
- Using **Unity Catalog** for secure governance

All AWS resources required for Databricks + S3 access are provisioned using Terraform following IAM and security best practices.

---

# 🏗 Architecture Overview

This project implements the **Medallion Architecture**:

Landing (S3 Raw Data)
↓
Bronze (Ingested Raw Tables)
↓
Silver (Cleaned / Conformed)
↓
Gold (BI + ML Ready Models)

# Data Structure

<p align="center">
  <img src="./images/data_diagram.png" width="600">
</p>

---


# 📦 Data Sources

- **Customers** → JSON files  
- **Addresses** → CSV files  
- **Memberships** → Image files (`binaryFile` format)  
- **Orders** → CSV  
- **Payments** → Monthly CSV extracts  
- **Refunds** → PostgreSQL table via JDBC  

---

# 🟨 Final Gold Outputs

### **customer_address**
Single record per customer with flattened address information.

### **order_monthly_summary**
Monthly customer order aggregated metrics:
- total orders  
- total items  
- total amount spent  

---

# Databricks S3 & Secrets Terraform Setup

All the AWS resources needed for Databricks unity catalog to securly connect to AWS S3 Bucket to access and store data are provisioned using Terraform. It follows best practices for IAM, Secrets Manager, and storage credentials.

---

# 📘 Spark Structured Streaming and Autoloader Project

This project ingests raw customer data from S3 into Delta Lake using Spark streaming, starting with standard Structured Streaming concepts and enhancing them using Databricks Auto Loader for scalability, performance, and schema management.

---

📥 End-to-End Streaming Workflow in This Project

1. Read files from S3 using Auto Loader (cloudFiles).

2. Add metadata columns, including:

   - file_path – source file location

   - ingest_date – timestamp when ingested

3. Write the transformed stream to a Bronze Delta table with checkpointing.

---

Streaming Dashboard:


<p align="center">
  <img src="./images/streaming_data.png" width="600">
</p>


---

Flow:
```pgsql
S3 → Auto Loader → Bronze Delta Table → Silver Transformation → Gold Analytics Tables
```

---

## AWS Infrastructure

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

5. **Copy files in S3 Bucket**
    - AWS CLI aws s3 sync command has been used to copy files in S3 bucket in specified folder structure.

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


### Example


# 🧪 How to Run

1. Deploy Infrastructure
from root folder:
    - terraform init
    - terraform plan
    - terraform apply

2. Upload Raw Data to S3

bash Copy code
```bash
aws s3 sync ./data/Customers s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Customers
```

3. Generate a Databricks Personal Access Token Databricks UI → User Settings → Developer → Access Tokens → Generate Token

4. Run Databricks Notebooks in Order

# 🔧 Prerequisites
Generate a Databricks Personal Access Token

Databricks UI → User Settings → Developer → Access Tokens → Generate Token

Create AWS Secrets Manager Entry

Secret name: db_secrets

Keys required:

    - databricks_host

    - databricks_token