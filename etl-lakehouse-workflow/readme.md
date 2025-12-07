# 📘 ETL Lakehouse Workflow Project 
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

# 🏗 ETL Architecture Overview

This project implements the **Medallion Architecture**:

```pgsql

Landing (S3 Raw Data)
↓
Bronze (Ingested Raw Tables)
↓
Silver (Cleaned / Conformed)
↓
Gold (BI + ML Ready Models)
```

---

# Data Structure

<p align="center">
  <img src="./../images/data_diagram.png" width="600">
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