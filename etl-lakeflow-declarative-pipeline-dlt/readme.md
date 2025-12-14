# 📘 Lakeflow Declarative Pipeline Project 
## Medallion Architecture + Terraform Infrastructure

This project demonstrates an end-to-end **LakeFlow declarative Pipeline** implementation, including:

- Automated infrastructure provisioning using **Terraform**
- Ingesting data from **multiple sources & formats**
- Applying the **Medallion Architecture** (Bronze → Silver → Gold)
- Using the **EXPECT** keyword for streaming data validation, along with the required actions, in both Spark SQL and PySpark.
- Building analytics-ready **Gold Layer** tables for BI & ML
- Using **Unity Catalog** for secure governance

All AWS resources required for Databricks + S3 access are provisioned using Terraform following IAM and security best practices.

---

# Data Structure

<p align="center">
  <img src="./../images/data_diagram.png" width="600">
</p>

---

## ETL Workflows

### 1. Customers Data Pipeline
Steps:
1. Ingest raw customer data → `bronze_customers`
2. Apply data quality expectations  
3. Store cleaned output → `silver_customers_clean`
4. Apply SCD Type 1 logic  
5. Store final curated table → `silver_customers`

---

### 2. Addresses Data Pipeline
Steps:
1. Ingest raw address data → `bronze_addresses`
2. Apply data quality expectations  
3. Store cleaned output → `silver_addresses_clean`
4. Apply SCD Type 2 logic  
5. Store final curated table → `silver_addresses`

---

### 3. Orders Data Pipeline
Steps:
1. Ingest raw order data → `bronze_orders`
2. Apply expectations and validation  
3. Store cleaned output → `silver_orders_clean`
4. Apply SCD Type 1 logic  
5. Store final curated table → `silver_orders`

---

## Gold Layer (Final Aggregated Model)

The Silver tables are joined to produce a final Gold dataset:

- `silver_customers`  
- `silver_addresses` (latest address per customer)  
- `silver_orders`  

### Final Metrics:
- `total_orders`  
- `total_items_order`  
- `total_order_amount`  

This table supports BI dashboards, ML feature engineering, and downstream analytics.

---

