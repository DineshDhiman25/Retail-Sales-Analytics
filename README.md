# Retail Sales Analysis

## Project Overview

This project analyzes retail sales data to identify sales trends, customer behaviour, regional performance, and product performance.

The project follows an end-to-end data analytics workflow using Python for data cleaning and exploratory analysis, MySQL for business-focused SQL analysis, and Tableau for dashboard visualization.

## Tools Used

- Python
- Pandas
- Jupyter Notebook
- MySQL
- DBeaver
- Tableau

## Project Workflow

### 1. Data Cleaning and Exploration

The dataset was cleaned and explored using Python and Pandas.

Key tasks included:

- Inspecting dataset structure and data types
- Checking missing values
- Checking duplicate records
- Standardizing column names
- Converting date columns to datetime format
- Creating additional date-related features
- Calculating shipping duration
- Performing exploratory data analysis

### 2. SQL Analysis

The cleaned dataset was imported into MySQL and analyzed using SQL.

The SQL analysis focused on answering business questions related to:

- Total sales
- Total orders
- Total customers
- Average order value
- Monthly and yearly sales trends
- Category and sub-category performance
- Regional sales performance
- Customer purchasing behaviour
- Top-performing products
- Year-over-year sales growth
- Product contribution to total sales

SQL concepts used in the project include:

- Aggregate functions
- GROUP BY
- Common Table Expressions (CTEs)
- Window functions
- LAG
- RANK and DENSE_RANK
- PARTITION BY
- CASE statements
- Date functions

### 3. Tableau Dashboard

An interactive Tableau dashboard was created to visualize key retail sales insights.
![alt text](<dashboard images/retail_sales_image.png>)

The dashboard includes:

- Total Sales KPI
- Total Orders KPI
- Total Customers KPI
- Average Order Value KPI
- Monthly Sales Trend
- Sales by Category
- Sales by Region
- Top 10 Products by Sales

## Key Insights

- Total sales reached approximately $2.25 million.
- The dataset contains 4,916 unique orders.
- 793 unique customers were identified.
- Average order value was approximately $458.
- Technology generated the highest sales among product categories.
- The West region recorded the highest sales.
- Sales generally increased over the analyzed period.
- A small group of high-performing products contributed significantly to total sales.

## Project Structure

```text
retail-sales-analysis/
│
├── data/
│   └── superstore_sales_cleaned.csv
│
├── sql/
│   ├── Retail_Sales_Analysis.sql
│   └── Superstore_sales_analysis_SQL_Insights.sql
│
├── tableau/
│   └── Retail Sales Analysis Dashboard
│
├── SuperstoreSalesAnalysis_JupyterNotebook.ipynb
│
└── README.md
