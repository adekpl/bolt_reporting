# Air Boltic Analytics & Reporting (Case Study)

This repository contains the **data modeling and reporting layer** designed for the *Air Boltic* case study — a fictional extension of Bolt’s mobility ecosystem into private and shared airplane rides.

The goal of this project is to demonstrate **end-to-end analytical modeling and reporting design** using industry best practices with **dbt + Snowflake **, while addressing the strategic objectives outlined in the case study.

---

## How to deploy project on local computer


```bash
# 1. Clone the repository
git clone [https://github.com/adekpl/sumup-reporting.git](https://github.com/adekpl/bolt_reporting.git)
cd sumup-reporting

# 2. Install dbt for Snowflake
pip install dbt-snowflake


In your ~/.dbt/profiles.yml, configure the Snowflake connection:

bolt_project:
  outputs:
    dev:
      account: ivqzzhs-ea23082
      database: bolt
      password: Bolt123Bolt123
      role: accountadmin
      schema: reporting
      threads: 2
      type: snowflake
      user: bolt
      warehouse: compute_wh
  target: dev

Move to your dbt project folder:

cd bolt_project
dbt run
dbt test


## Tech Stack

| Layer | Tool | Purpose |
|-------|------|----------|
| **Data Loading** | Manual upload | Data for modeling |
| **Data Storage & Compute** | Snowflake | Raw and processed data layers |
| **Transformation** | dbt | Data modeling, testing, documentation |
| **Exploration & BI** | TBD (Looker / Tableau) | Visualization and semantic layer - To Develop|
| **Version Control** | GitHub | Collaboration, code review, and CI/CD |
| **Orchestration** | TBD | Scheduling, alerts, and automation |

---

## Data Model Overview

The data model follows a **dimensional architecture** with three primary layers: **staging, dimension & fact, mart**.

### 🧱 Core Layers

| Layer | Purpose | Example Models |
|--------|----------|----------------|
| **staging (stg_)** | Standardizes raw data from CSV/JSON uploads or external sources | `stg_aeroplane_model` |
| **dimensions (dim_)** | Provides reference and lookup tables for consistent joins | `dim_customer`, `dim_aeroplane_model` |
| **facts (fact_)** | Captures transactional or event-level data | `fact_orders`, `fact_revenue` |
| **marts (mart_)** | Pre-aggregated and aggregated analytical datasets for BI & dashboards | `raport_daily_kpis`, `mart_air_boltic_detailed` |

---

## 🧠 Design Highlights

- **Timezone-standardized trips:**  
  All timestamps are converted to UTC using IANA city mappings (`dim_timezone`) for accurate cross-region comparisons.

- **Data quality built-in:**  
  The `trip_duration_quality_flag` identifies invalid or suspicious durations automatically.

- **Modular & reusable:**  
  Each model builds logically from the previous layer, ensuring maintainability and clarity.

- **Rich documentation:**  
  Every model has a `.yml` file with column-level documentation and tests to ensure consistency and trust.

---

### 🛠️ Ideal CI/CD Stack

- **Airflow:** Orchestration of dbt runs, data loads, alerts, and scheduling  
- **dbt Cloud:** Development, documentation, and testing  
- **Fivetran:** Automated data ingestion from external systems  
- **Snowflake:** Scalable compute and storage for analytical processing  
- **GitHub:** Version control, PR-based reviews, and CI automation  , Development and Production environment
- **BI Layer (Looker / Tableau)
- ** Develop Semenatic Layer in DBT or Looker + Incremental Models

### 🛠️ How would your answer differ in the real world use case where resources are limited and perfect tooling might not be available? 
-- ** use dbt cloud for automation and CI/CD / or event just snowflake DBT
-- ** Snowfalke as data storage and integration tool + dashboard in streamlit
-- ** github for version control
-- ** Gsheet as reporting tool connected to Snowflake
-- ** Maybe fivetran as loading tool -- depend from budghet

---

## Future Enhancements

### Model Descriptions

#### `stg_aeroplane_model`
- Cleans and standardizes the raw `aeroplane_model.json`
- Extracts manufacturer, model, seat capacity, distance, weight, and engine type  
- Serves as the canonical aircraft model source  

#### `dim_aeroplane_model`
- Dimension table describing each aircraft model  
- Adds seat and distance categories (e.g., “1–10”, “201+”) for segmentation  
- Joins to trip and utilization reports  

#### `dim_customer_group`
- Defines customer group categories (Company, Organisation, Private Group, etc.)  
- Includes a fallback “no data” row for full categorization  

#### `dim_customer`
- Contains customer-level information (name, email, phone, group)  
- Ensures referential integrity with `dim_customer_group`  

#### `dim_timezone`
- Maps all supported cities to their IANA time-zone identifiers  
- Enables UTC conversion for all trip timestamps  

#### `dim_trip`
- Represents individual flights on the Air Boltic platform  
- Adds UTC timestamps and calculated durations  
- Includes `trip_duration_quality_flag` (VALID, INVALID, SUSPICIOUS)  

#### `fact_orders`
- Transactional booking data: `order_id`, `trip_id`, `customer_id`, seat, price, status  
- Core fact table for revenue and passenger analytics  

#### `fact_passengers_on_trip`
- Identifies each passenger-seat-trip combination  
- Supports occupancy and seat-level behavior analysis  

#### `fact_revenue`
- Aggregates recognized revenue per day (UTC) after completed trips  
- Used for financial and executive reporting  

#### `report_daily_kpis`
- Daily Air Boltic summary: active users, trips, revenue, avg ticket, cancellations  
- Core for Executive KPI dashboards  

#### `report_route_performance`
- Aggregates by route (origin × destination)  
- Tracks trips, passengers, revenue, and profitability  


#### `rpt_revenue_by_day_city`
- Daily revenue breakdown by city of origin/destination  
- Enables geographic trend analysis  

#### `mart_air_boltic_detailed`
- Wide, denormalized mart joining all key dimensions and facts  
- Basis for ad-hoc queries and Looker dashboards  

---

## 🔮 Next Steps

1. Implement **incremental materializations** for large fact tables (optimized daily loads).  
2. Finalize and connect the **BI tool** (Looker / Tableau) for executive dashboards.  
3. Add **dbt snapshots** for slowly changing dimensions (SCD Type 2).  
4. Integrate **Airflow orchestration** for production-grade automation and alerting.  
5. Add **data lineage visualization** via dbt docs or Monte Carlo.  


