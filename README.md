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

🧱 Model Descriptions
stg_aeroplane_model

Cleans and standardizes the raw aeroplane_model.json file.
Extracts key fields such as manufacturer, model, maximum seats, weight, distance, and engine type.
Acts as the canonical source for aircraft specifications.

dim_aeroplane_model

Dimension table describing every aircraft model available in the Air Boltic system.
Adds seat and distance category buckets (e.g. “1–10”, “201+”) for easy segmentation and joins to trip and utilization reports.

dim_customer_group

Static reference table defining customer groups (Company, Organisation, Private Group, etc.).
Includes a “no data” fallback row to ensure all orders are categorized, even when customer group information is missing.

dim_customer

Holds all customer-level information: name, email, phone number, and associated customer group.
Ensures referential integrity with dim_customer_group and provides clean keys for analytics.

dim_timezone

Maps all supported cities to their IANA time-zone identifiers (e.g. Europe/Paris, America/New_York).
Used to convert local flight departure and arrival timestamps into UTC for consistent duration calculations.

dim_trip

Represents each individual flight (trip) offered on the Air Boltic marketplace.
Enriches trips with origin/destination time-zones, UTC-converted timestamps, and a calculated flight duration.
Includes a quality flag (VALID, INVALID, SUSPICIOUS) to catch time-zone or data-entry issues.

fact_orders

Transactional fact table of all seat bookings.
Captures order_id, trip_id, customer_id, seat number, price in EUR, and booking status.
Forms the core revenue and passenger activity dataset.

fact_passengers_on_trip

Intermediate fact table that uniquely identifies each passenger-seat-trip combination (passenger_id).
Used to analyze passenger counts, occupancy, and seat-level behaviors.

fact_revenue

Aggregates recognized revenue per reporting date (UTC) once flights are completed.
Used for financial and executive reporting aligned with accounting standards.

rpt_daily_kpis

Daily summary of Air Boltic performance.
Shows key metrics such as active users, completed trips, total revenue, average ticket price, and cancellation rate.
Main input for the Executive KPI Dashboard.

rpt_route_performance

Aggregates performance by route (origin × destination) and reporting date.
Measures total trips, passengers, revenue, and average ticket prices to track route profitability.

rpt_customer_segments

Summarizes customer behavior and revenue by customer group type.
Helps identify which market segments generate the most bookings and highest average spend.

rpt_aircraft_utilization

Analyzes operational efficiency per aircraft and model.
Includes total and average flight hours, trip counts, and utilization per day.
Crucial for fleet planning and performance monitoring.

rpt_revenue_by_day_city

Daily revenue breakdown by origin and destination city.
Supports geographic revenue distribution and regional trend analysis.

mart_air_boltic_detailed

A wide analytical mart joining all dimensions and facts into a single, denormalized dataset.
Each row represents one order enriched with customer, flight, aircraft, and revenue attributes.
Serves as the foundation for ad-hoc queries and Looker self-service dashboards.

If additional time were available, next steps would include:
1. **Incremental materializations** for large fact tables (optimized daily loads).  
2. Choose BI Tool solution for reporting

