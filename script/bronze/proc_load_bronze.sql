CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$

DECLARE start_time TIMESTAMP;
DECLARE end_time TIMESTAMP;

BEGIN

	BEGIN

		start_time := clock_timestamp();
	
		RAISE NOTICE '==============================================================================';
		RAISE NOTICE 'LOADING BRONZE LAYER';
		RAISE NOTICE '==============================================================================';
	
	
		RAISE NOTICE '------------------------------------------------------------------------------';
		RAISE NOTICE 'LOADING CRM Tables';
	
	
		RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
		COPY bronze.crm_cust_info
		FROM 'F:\Ganesh Tagad\Project&Internship\DataWarehouse_Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FORMAT csv,
			HEADER true,
			DELIMITER ','
		);
	
		RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;	
		RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';	
		COPY bronze.crm_prd_info
		FROM 'F:\Ganesh Tagad\Project&Internship\DataWarehouse_Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FORMAT csv,
			HEADER true,
			DELIMITER ','
		);
	
		RAISE NOTICE '>> Truncating Table: bronze.crm_sales_detials';
		TRUNCATE TABLE bronze.crm_sales_detials;	
		RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_detials';
		COPY bronze.crm_sales_detials
		FROM 'F:\Ganesh Tagad\Project&Internship\DataWarehouse_Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FORMAT csv,
			HEADER true,
			DELIMITER ','
		);
	
		
		RAISE NOTICE '------------------------------------------------------------------------------';
		RAISE NOTICE 'LOADING ERP Table';
	
		RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;	
		RAISE NOTICE '>> Inserting Data Into: bronze.erp_loc_a101';
		COPY bronze.erp_loc_a101
		FROM 'F:\Ganesh Tagad\Project&Internship\DataWarehouse_Project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FORMAT csv,
			HEADER true,
			DELIMITER ','
		);
	
		RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		RAISE NOTICE '>> Inserting Data Into: bronze.erp_cust_az12';
		COPY bronze.erp_cust_az12
		FROM 'F:\Ganesh Tagad\Project&Internship\DataWarehouse_Project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FORMAT csv,
			HEADER true,
			DELIMITER ','
		);
	
		RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		RAISE NOTICE '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		COPY bronze.erp_px_cat_g1v2
		FROM 'F:\Ganesh Tagad\Project&Internship\DataWarehouse_Project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FORMAT csv,
			HEADER true,
			DELIMITER ','
		);

	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE '==============================================================================';
		RAISE WARNING 'CRITICAL ERROR: Failed to Bronze Layer Data. Reason: %', SQLERRM;
		RAISE NOTICE '==============================================================================';	
	END;

	end_time := clock_timestamp();

	RAISE NOTICE '==============================================================================';
	RAISE NOTICE 'Bronze Layer start time: %', start_time;
	RAISE NOTICE 'Bronze Layer end time: %', end_time;
	RAISE NOTICE 'Bronze Layer Total execution time: %', EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '==============================================================================';	

END;
$$;




CALL bronze.load_bronze();
