-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Create company summary in the gold layer
-- MAGIC 1. Create the gold schema if doesn't already exists
-- MAGIC 1. Create the gold company_summary with the number of companies per country. 

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS gold
     MANAGED LOCATION 's3a://amzn-s3-gizmobox-project-bucket/gold';  

-- COMMAND ----------

DROP TABLE IF EXISTS gold.company_summary;

CREATE TABLE gold.company_summary
AS
SELECT country,
       COUNT(*) AS num_companies
  FROM silver.companies
 GROUP BY country;    
