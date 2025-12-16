# PySpark code
companies_df = spark.read.table("silver.companies")
summary_df = companies_df.groupBy("country").count()
summary_py = summary_df.collect()


# Python code
total_companies = sum(row['count'] for row in summary_py)
print(f"Total number of companies: {total_companies}")