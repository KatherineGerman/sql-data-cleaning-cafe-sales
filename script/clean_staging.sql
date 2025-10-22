
-- Check columns and data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'cafe_sales';

-- Handle missing numeric values
-- Quantity: fill NULLs with mean or median (example 3)
UPDATE staging.cafe_sales
SET quantity = 3
WHERE quantity IS NULL;

-- Total_spent: replace NULLs with median
WITH median_cte AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_spent) 
        OVER () AS median_total_spent
    FROM staging.cafe_sales
    WHERE total_spent IS NOT NULL
)
UPDATE staging.cafe_sales
SET total_spent = (SELECT TOP 1 median_total_spent FROM median_cte)
WHERE total_spent IS NULL;

-- Handle categorical values (replace NULL, ERROR, UNKNOWN)
UPDATE staging.cafe_sales
SET item = 'Juice'
WHERE item IS NULL OR item = 'ERROR' OR item = 'UNKNOWN';

UPDATE staging.cafe_sales
SET payment_method = 'Digital Wallet'
WHERE payment_method IS NULL OR payment_method = 'ERROR' OR payment_method = 'UNKNOWN';

UPDATE staging.cafe_sales
SET location = 'Takeaway'
WHERE location IS NULL OR location = 'ERROR' OR location = 'UNKNOWN';

-- Add derived columns for analysis
ALTER TABLE staging.cafe_sales
ADD transaction_month NVARCHAR(20), transaction_week NVARCHAR(20);

UPDATE staging.cafe_sales
SET 
    transaction_month = DATENAME(month, transaction_date),
    transaction_week = DATENAME(weekday, transaction_date);

-- Verify results
SELECT TOP 10 * FROM staging.cafe_sales;
