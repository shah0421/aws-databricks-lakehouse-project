-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Transform the companies data and insert into silver layer
-- MAGIC 1. Create the silver schema if doesn't already exists
-- MAGIC 1. Create the silver companies table with the data bronze layer and generate the columns company_id and founded_year. 

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS silver
     MANAGED LOCATION 's3a://amzn-s3-gizmobox-project-bucket/silver';  

-- COMMAND ----------

DROP TABLE IF EXISTS silver.companies;

CREATE TABLE silver.companies
  (company_id   BIGINT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   company_name STRING,
   founded_date DATE,
   founded_year INT GENERATED ALWAYS AS (YEAR(founded_date)),
   country      STRING);

INSERT INTO silver.companies 
(company_name, founded_date, country)
SELECT company_name,
       founded_date,
       country
  FROM bronze.companies;    
