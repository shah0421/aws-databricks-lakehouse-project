# 📘 ETL With Apache Spark Streaming Project

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
  <img src="./../images/streaming_data.png" width="600">
</p>

---

# 📦 Data Sources

- **Customers_autoloader** → JSON files 
- **Customers_stream** → JSON files

---

Flow:
```pgsql
S3 → Auto Loader → Bronze Delta Table → Silver Transformation → Gold Analytics Tables
```

---

# 🟫 Stores Streaming Data in Bronze Layer for Later use

### **customer_steam**
    - Stores data as defined in the static schema

### **customers_autoloader**
    - Stores data dynamically by using automatic schema inference from sample files.

---