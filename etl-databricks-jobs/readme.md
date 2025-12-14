# 📘 Databricks Jobs Project
## Medallion Architecture + Terraform Infrastructure

## Overview
This project implements a **Databricks multi-layer data job** following the **Bronze → Silver → Gold** architecture.  
The pipeline ingests company data from a landing folder, performs transformations, and produces aggregated insights.

---

## Architecture
The pipeline is organized into three layers:

- **Bronze Layer**: Raw data ingestion
- **Silver Layer**: Cleansed and transformed data
- **Gold Layer**: Aggregated and business-ready data

---

## Job Structure

### 1. Bronze Layer – Ingest Companies Data
**Task Name:** `process_company_data`

#### Responsibilities
- Create the `bronze` schema if it does not already exist
- Read raw companies data from the landing folder
- Create the `bronze.companies` table
- Store raw data with minimal transformation

#### Output
- **Table:** `bronze.companies`

---

### 2. Silver Layer – Transform Companies Data
**Task Name:** `silver.companies`

#### Responsibilities
- Create the `silver` schema if it does not already exist
- Read data from `bronze.companies`
- Apply data transformations and cleansing
- Generate derived columns:
  - `company_id`
  - `founded_year`
- Create the `silver.companies` table

#### Output
- **Table:** `silver.companies`

---

### 3. Gold Layer – Company Summary
**Task Name:** `03_gold_company_summary`

#### Responsibilities
- Create the `gold` schema if it does not already exist
- Aggregate company data from the silver layer
- Calculate the number of companies per country
- Create a business-ready summary table

#### Output
- **Table:** `gold.company_summary`
- **Metric:** Number of companies per country

---

## Data Flow
```text
Landing Folder
      ↓
Bronze Layer (Raw Data)
      ↓
Silver Layer (Transformed Data)
      ↓
Gold Layer (Aggregated Insights)
```

---
## Email notification after job success/failure

<p align="center">
  <img src="./../images/job-notification.png" width="600">
</p>

---