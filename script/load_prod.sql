/*
=================================================================================================================
In this script I created new columns such as 'transaction_week' and 'transaction_month' for further analysis. 

Created a new table to load the clean data and inserted the new columns
*/

-- Create prod table (final clean layer)
IF OBJECT_ID ('prod.cafe_sales', 'U') IS NOT NULL
DROP TABLE prod.cafe_sales
GO
CREATE TABLE prod.cafe_sales(
	id INT IDENTITY(1,1) PRIMARY KEY,
	transaction_id NVARCHAR(50),
	transaction_date DATE,
	transaction_month NVARCHAR(20),
	transaction_week NVARCHAR(20),
	item NVARCHAR(50),
	quantity tinyint,
	price_per_unit FLOAT,
	total_spent FLOAT,
	payment_method NVARCHAR(50),
	location NVARCHAR(50)
);

-- Insert clean data from staging
NSERT INTO prod.cafe_sales(
	transaction_id,
	transaction_date,
	transaction_month,
	transaction_week,
	item, 
	quantity,
	price_per_unit,
	total_spent,
	payment_method,
	location
)

SELECT
	transaction_id,
	transaction_date,
	DATENAME(month,transaction_date) AS transaction_month,
	DATENAME(weekday, transaction_date) AS transaction_week,
	item, 
	quantity,
	price_per_unit,
	total_spent,
	payment_method,
	location
FROM staging.cafe_sales

-- Verify final table
SELECT TOP 10 * FROM prod.cafe_sales_cleaned;
SELECT COUNT(*) AS total_rows FROM prod.cafe_sales_cleaned;
