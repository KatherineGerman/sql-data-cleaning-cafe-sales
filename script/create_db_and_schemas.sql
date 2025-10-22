
/*
===============================================================================
Create Database and Schemas
===============================================================================

Script Purpose:
  This script creates a new database names 'CafeSalesDB' after checking if already exists.
  If the database exists, it is dropped and recreated. Additionally, the script set up three schemas within  
  the database: 'raw', 'staging', and 'prod'.
*/

--Drop and recreate the DATABASE
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'CafeSalesDB')
BEGIN
	ALTER DATABASE CafeSalesDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE CafeSalesDB
END;
GO
  --Create the 'CafeSalesDB' Databse
CREATE DATABASE CafeSalesDB;
GO

USE CafeSalesDB;
GO

  --Create Schemas
CREATE SCHEMA raw;
GO
CREATE SCHEMA staging;
GO
CREATE SCHEMA prod;
GO
