# Café Sales Data Cleaning Project

## Objective
Clean and structure a café sales dataset using SQL Server, applying a layered architecture:
**raw → staging → prod**.  
The goal is to transform dirty raw data into clean, analysis-ready information.

---

## Dataset
- Source: Kaggle  
- Rows: 10,000  
- Columns: 8  
- [Dataset link](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training/data)  

### Columns
| Column | Description |
|--------|------------|
| transaction_id | Unique identifier for each transaction |
| item | Product name |
| quantity | Quantity of items purchased |
| price_per_unit | Price per item |
| total_spent | Total spent per transaction (quantity * price_per_unit) |
| payment_method | Payment method used (Cash, Digital Wallet, Credit Card) |
| location | Transaction location (In-store, Takeaway) |
| transaction_date | Date of the transaction |

---

## Project Architecture
1. **raw**: Original data imported from CSV.  
2. **staging**: Cleaned and normalized data, including flags and derived columns for analysis.  
3. **prod**: Final clean data ready for analysis and reporting (no flags).

---

## SQL Scripts

### 1️⃣ 01_create_db_and_schemas.sql
- Creates the database `CafeSalesDB` and schemas `raw`, `staging`, and `prod`.

### 2️⃣ 02_load_raw_data.sql
- Creates the staging table and loads raw data from the `raw` schema.  
- Verifies data import.

### 3️⃣ 03_clean_staging.sql
- Cleans the data:
  - Replaces NULL, ERROR, UNKNOWN values.
  - Numeric columns: median or mean.
  - Categorical columns: mode.
  - Derived columns: `transaction_month` and `transaction_week`.
- Verifies cleaned data.

### 4️⃣ 04_load_prod.sql
- Creates the final table `prod.cafe_sales_cleaned` with auto-incrementing ID.  
- Copies cleaned data from staging.  
- Verifies results.

---

## Data Cleaning Steps

- Replace NULL, ERROR, and UNKNOWN values in both numeric and categorical columns.  
- Numeric columns: median for `total_spent`, mean or median for `quantity`.  
- Categorical columns: mode for `item`, `pay
