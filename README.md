 ✈️ Air Boltic Analytics & Reporting (Case Study)

This repository contains the **data modeling and reporting layer** designed for the *Air Boltic* case study — a fictional extension of Bolt’s mobility ecosystem into private and shared airplane rides.  

The goal of this project is to demonstrate **end-to-end analytical modeling and reporting design** using industry best practices with **dbt + Snowflake + Looker**, while addressing the strategic objectives outlined in the case study.

## 🧩 Tech Stack

| Layer | Tool | Purpose |
|-------|------|----------|
| **Data Loaind | manual upload of csv files |
| **Data storage & Computer** | Snowfalke | Raw file and JSON ingestion |
| **Transformation** | dbt | Data modeling, testing, documentation |
| **Exploration & BI** | TBD |  |
| **Version Control** | GitHub | Collaboration and CI/CD |

## 🏗️ Data Model Overview

The data model follows a **standard dimensional architecture** with **staging, dimension, fact, and mart** layers:

### 🧱 Core Layers

| Layer | Purpose | Example Models |
|--------|----------|----------------|
| **staging (stg_)** | Standardize raw data from S3/Databricks sources |
| **dimensions (dim_)** | Reference data for consistent lookups |
| **facts (fact_)** | Transaction-level business events  |
| **marts (mart_)** | Analytical aggregations for reporting  |

---

## 🧠 Design Highlights

- **Timezone-standardized trips:**  
  All timestamps are converted to UTC using IANA city mappings (`dim_timezone`) for accurate cross-region comparisons.  

- **Data quality built-in:**  
  `trip_duration_quality_flag` ensures valid durations and identifies timezone anomalies automatically.  

- **Modular, reusable models:**  
  Each transformation layer builds logically from the previous one for maintainability and clarity.  

- **Rich documentation:**  
  Every model includes a `.yml` file with detailed column-level documentation and data tests.  

---

## ⚙️ CI/CD & Development Process

In a real-world setup, this project would be deployed using a **multi-environment CI/CD workflow**:

| Environment | Purpose |
Tools:
Airflow: For orchestration & automation of  DBT Run, alerts. Data Load, Alerting
DBT: For data modeling, testing
GitHub: For CI/CD and version control
Fivetran: For Data Load
Semenatic Layer: Developed in DBT Cloud or BI Solution  like Tableau/Looker

## 🚀 Future Enhancements

If additional time were available, next steps would include:
1. **Incremental materializations** for large fact tables (optimized daily loads).  
2. Choose BI Tool solution for reporting

