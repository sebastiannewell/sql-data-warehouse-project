/*
========================================
Create Database and Schemas
========================================
Script Purpose:
  This script creates a new datbase called 'DataWarehouse' after checking if it already exists. If the database exists, it is
  dropped and recreated. Additionally the script sets up a bronze, silver, and gold schema within the database.
WARNING:
  Running this script will drop the entire 'DataWarehouse' database if it exists. All data in the database will be permanently 
  deleted. Proceed with caution and ensure you have proper backups.
*/

USE master;
GO

-- Check if DataWarehouse database exists first
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Create the DataWarehouse database
CREATE DATABASE DataWarehouse;
USE DataWarehouse;
GO

-- Create the three schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
