# E-commerce SQL Analysis — Olist Dataset

## Project Overview
This project analyses 99,441 real Brazilian e-commerce orders from Olist (2016–2018)
using SQL in Google BigQuery. The goal was to simulate a real data analyst workflow:
ingesting raw data, validating quality, cleaning, and extracting business insights.

This is Project 1 of a 5-part SQL portfolio series.

---

## Dataset
- **Source:** [Kaggle — Brazilian E-commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Primary table:** `olist_orders_dataset.csv`
- **Rows:** ~99,441 orders
- **Period:** September 2016 – October 2018
- **Tool:** Google BigQuery (free tier)

---

## Project Structure

sql-ecommerce-portfolio/
│
├── sql/
│   ├── 01_create_table.sql        -- Schema design
│   ├── 02_data_quality_checks.sql -- Validation queries
│   ├── 03_cleaning.sql            -- Deduplication & fixing nulls
│   └── 04_analysis.sql            -- Business insight queries
│
├── screenshots/
│   ├── monthly_trend.png
│   ├── delivery_performance.png
│   └── order_status_breakdown.png
│
└── README.md

---

## Workflow

### Step 1 — Schema Design & Ingestion
Designed a typed schema before loading, assigning correct BigQuery types
to each column (`TIMESTAMP` for dates, `STRING` for IDs) and uploaded
the CSV via the BigQuery UI.

### Step 2 — Data Quality Checks
Ran systematic checks across every column before any analysis:

| Check | Result |
|---|---|
| Total rows | 99,441 |
| Duplicate order_ids | 0 ✅ |
| Null order_ids | 0 ✅ |
| Impossible delivery timestamps | 0 ✅ |
| Orders missing delivery date | ~2,965 (not yet delivered — expected) ✅ |
| Unexpected status values | None found ✅ |

### Step 3 — Cleaning
- Removed orders with null delivery timestamps for delivery analysis
- Used `ROW_NUMBER() OVER(PARTITION BY order_id)` pattern to handle
  any duplicates defensively
- Created `olist_orders_clean` as a separate table, preserving raw data

### Step 4 — Analysis
Wrote business-focused queries to extract actionable insights.

---

## Key Findings

### Order Volume
- Orders grew consistently from late 2016 through 2018
- **November 2017** saw the largest single-month spike — driven by Black Friday
- Monday is the highest order volume day of the week

### Delivery Performance
- Overall late delivery rate: **~7.4%**
- Average delivery time: **~12 days** from purchase to delivery
- Delivery times increased during Q4 (holiday season pressure)

### Order Status
- ~97% of orders reached `delivered` status
- Cancellation rate remained consistently below 1%

---

## SQL Concepts Demonstrated
- Schema design with appropriate data types
- Data quality validation with `COUNTIF`, `COUNT(DISTINCT)`
- Deduplication using `ROW_NUMBER()` window function
- Date functions: `DATE_TRUNC()`, `DATE_DIFF()`, `EXTRACT()`
- Aggregations: `COUNT()`, `AVG()`, `MIN()`, `MAX()`
- Window functions: `SUM() OVER()`, `LAG()`
- CTEs for readable, layered query structure
- `HAVING` clause for post-aggregation filtering

---

## How to Reproduce
1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Create a free [Google BigQuery](https://cloud.google.com/bigquery) project
3. Create a dataset named `ecommerce`
4. Upload `olist_orders_dataset.csv` via the BigQuery UI
5. Run the `.sql` files in order from the `/sql` folder

---

## Next Steps — Project 2
Join the orders table with `olist_order_items`, `olist_customers`, and
`olist_products` to answer: **which product categories drive the most
revenue per region?**

---

## Author
Aakriti Sharma
[LinkedIn](www.linkedin.com/in/aakriti-sharma-21039a386) · [GitHub](https://github.com/aakritisharma001)
