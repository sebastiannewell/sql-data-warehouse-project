/*
=================================================
  Validate silver.crm_cust_info
=================================================
*/
-- Check for nulls/duplicates in primary key
SELECT
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for unwanted spaces
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Data standardization & consistency
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

/*
=================================================
  Validate silver.crm_prd_info
=================================================
*/
-- Check for nulls/duplicates in primary key
SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted spaces
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Data standardization & consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check for invalid date orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

/*
=================================================
  Validate silver.crm_sales_details
=================================================
*/
-- Check for invalid date orders
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_due_dt < sls_order_dt

-- Check for invalid sales/prices
SELECT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

/*
=================================================
  Validate silver.erp_CUST_AZ12
=================================================
*/
-- Identify out-of-range dates
SELECT DISTINCT
	BDATE
FROM silver.erp_CUST_AZ12
WHERE BDATE < '1924-01-01' OR BDATE > GETDATE()

-- Data standardization & consistency
SELECT DISTINCT GEN
FROM silver.erp_CUST_AZ12
