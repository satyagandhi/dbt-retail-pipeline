# dbt-retail-pipeline

A layered ELT pipeline built with dbt Core and BigQuery demonstrating
production patterns for data modeling, quality, and governance.

## Architecture

raw_orders / raw_customers (BigQuery source tables)
        |
   [ Staging ]       stg_orders, stg_customers
        |             rename, cast, filter nulls
   [ Intermediate ]  int_customer_orders
        |             join orders with customers
   [ Marts ]         fct_orders (incremental), dim_customers (table)
        |
   Analytics and BI consumers

## Key Features

- Incremental fact table using merge strategy on order_id
- Snapshot tracking customer tier changes over time
- Custom surrogate key macro used across dim and fact models
- Source freshness checks with warn and error thresholds
- Schema tests: not_null, unique, accepted_values on key columns
- Column level descriptions for lineage and documentation

## Tech Stack

dbt Core, Google BigQuery, Google Cloud Storage, Apache Airflow

## How to Run

pip install dbt-bigquery
dbt deps
dbt source freshness
dbt build
