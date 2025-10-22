/*
================================================================
Script Purpose:
    This script creates tables in the 'staging' schema, dropping existing tables 
    if they already exist.

*/

--create table staging.cafe_sales
IF OBJECT_ID('staging.cafe_Sales', 'U') IS NOT NULL --Drop table if exists and recreate it
	DROP TABLE staging.cafe_sales;
GO
CREATE TABLE staging.cafe_sales
(
	transaction_id NVARCHAR(50),
	item NVARCHAR(50),
	quantity tinyint,
	price_per_unit float,
	total_spent float,
	payment_method NVARCHAR(50),
	location NVARCHAR(50),
	transaction_date DATE

);

--Insert raw data into table staging.cafe_sales to clean it.

INSERT staging.cafe_sales
SELECT *
FROM raw.cafe_sales;

SELECT TOP 10 * FROM staging.cafe_sales
