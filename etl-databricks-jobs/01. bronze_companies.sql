-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Ingest companies data into bronze layer
-- MAGIC 1. Create the bronze schema if doesn't already exists
-- MAGIC 1. Create the bronze companies table with the data from landing folder. 

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS bronze
     MANAGED LOCATION 's3a://amzn-s3-gizmobox-project-bucket/bronze';  

-- COMMAND ----------

DROP TABLE IF EXISTS bronze.companies;

CREATE TABLE bronze.companies
AS
SELECT company_name, founded_date, country
  FROM read_files('s3://amzn-s3-gizmobox-project-bucket/top_tech_companies/landing/companies',
                  format => 'csv',
                  header => true);
