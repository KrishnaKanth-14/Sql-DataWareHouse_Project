======================================================================
 DDL : SCRIPT BRONZE TABLE 
=====================================================================
SCRIPT PURPOSE : 
THIS SCRIPT CREATES  TABLES IN THE 'BRONZE'  SCHEMA DROPPING EXISISTING TABLES 
IF THEY ALREADY EXIST 
RUN THIS SCRIPT TO REDEFINE THE DDL STRUCTURE OF 'BRONZE' TABLES
====================================================================
 CREATE OR ALTER PROCEDURE BRONZE.LOAD_BRONZE AS 

BEGIN

    DECLARE @Start_date DATETIME,
	 	@End_date DATETIME,
	 	@Batch_start_time DATETIME,
	 	@Batch_end_time DATETIME

			SET @Batch_start_time = GETDATE();
		
   BEGIN TRY 

		PRINT '=============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=============================================================';

		PRINT '>> TRUNCATING TABLE :Bronze.CRM_Cust_INFO';
		TRUNCATE TABLE BRONZE.CRM_CUST_INFO;
		PRINT 'Inserting Data into : Bronze.CRM_Cust_Info';

		SET @Start_date = GetDate();

		BULK INSERT BRONZE.CRM_CUST_INFO
		FROM 'C:\Users\dabhi\OneDrive\Desktop\Sql Warehouse Project\Data\source_crm\Cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @End_date = GETDATE();
		PRINT '>> Load Duration time in Seconds : ' + CAST (DATEDIFF(SECOND, @Start_Date, @End_Date) AS NVARCHAR) + 'Seconds'
		PRINT '>>>>>>>>>>----------------------------------------------'

		PRINT '>> TRUNCATING TABLE :Bronze.CRM_PRD_INFO';
		SET @Start_date = GETDATE();
		TRUNCATE TABLE BRONZE.CRM_PRD_INFO;
		PRINT 'Inserting Data into : Bronze.CRM_PRD_Info';
		BULK INSERT BRONZE.CRM_PRD_INFO
		FROM 'C:\Users\dabhi\OneDrive\Desktop\Sql Warehouse Project\Data\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @End_date = GETDATE();
		PRINT 'Load Duration in Bronze CRM PRD INFO' + CAST(DATEDIFF( SECOND,@Start_date,@End_date) AS NVARCHAR) + 'Seconds' ;
		PRINT '>>>>>>>>>>>-------------------------------------------------------------------------------'
		PRINT '>> TRUNCATING TABLE :Bronze.CRM_Sales_Details';
		SET @Start_date = GETDATE()
		TRUNCATE TABLE BRONZE.CRM_Sales_Details;
		PRINT 'Inserting Data into : Bronze.CRM_Sales_Details';
		BULK INSERT BRONZE.CRM_Sales_Details
		FROM 'C:\Users\dabhi\OneDrive\Desktop\Sql Warehouse Project\Data\source_crm\Sales_Details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @End_date = GETDATE()
		PRINT 'Loading Duration Data into CRM Sales Details' + CAST(DATEDIFF(SECOND,@START_DATE,@END_DATE) AS NVARCHAR) + 'Seconds';
		PRINT '>>>>>-------------------------------------------------------------------'
		PRINT '-----------------SECOND DATA SOURCE ERP-------------'
		SET @Start_date = GETDATE()
		PRINT 'TRUNCATE TABLE : BRONZE.ERP_CUST_AZ12';
		TRUNCATE TABLE BRONZE.ERP_CUST_AZ12;
		PRINT 'Inserting Data into : Bronze.ERP_CUST_AZ12';
		BULK INSERT BRONZE.ERP_CUST_AZ12
		FROM 'C:\Users\dabhi\OneDrive\Desktop\Sql Warehouse Project\Data\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @End_date = GETDATE()
		PRINT 'Load Duration for Bronze ERP Cust time' + CAST(DATEDIFF( SECOND, @START_DATE, @END_DATE) AS NVARCHAR) + 'Seconds'

		PRINT '>>>>>>>>>>>>-------------------------------------------------------------------'
		PRINT 'TRUNCATE TABLE : BRONZE.ERP_Loc_A101';
		SET @Start_date = GETDATE()
		TRUNCATE TABLE BRONZE.ERP_Loc_A101;
	
		PRINT 'Inserting Data into : Bronze.ERP_Loc_A101';
	
		BULK INSERT BRONZE.ERP_Loc_A101
		FROM 'C:\Users\dabhi\OneDrive\Desktop\Sql Warehouse Project\Data\source_erp\Loc_A101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @End_date = GETDATE();
		PRINT 'Load Duration for Bronze ERP : ' + CAST(DATEDIFF(SECOND, @START_DATE, @END_DATE) AS NVARCHAR) + 'Seconds' 
		PRINT '>>>>>>>>>>>>>>>>>>------------------------------------------------------------------'
		PRINT 'TRUNCATE TABLE : BRONZE.ERP_CUST_AZ12';
		SET @Start_date = GETDATE();
		TRUNCATE TABLE BRONZE.ERP_PX_CAT_G1V2;

		PRINT 'Inserting Data into : Bronze.ERP_PX_CAT_G1V2';
	
		BULK INSERT BRONZE.ERP_PX_CAT_G1V2
		FROM 'C:\Users\dabhi\OneDrive\Desktop\Sql Warehouse Project\Data\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @End_date = GETDATE();
		PRINT 'Load Duration for Bronze ERP :' + CAST(DATEDIFF(SECOND, @START_DATE, @END_Date) AS NVARCHAR)+'Seconds'

		PRINT '>>>>>>>>>>>>>>>>>>>>----------------------------------------------------------'

		END TRY 
	BEGIN CATCH
		
		PRINT '==================================';
		PRINT 'ERROR OCCURED DURING BRONZE LAYER';
		PRINT 'ERROR MESSAGE  ' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE  ' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'ERROR MESSAGE  ' + CAST(ERROR_STATE() AS NVARCHAR)

	END CATCH
	SET @Batch_end_time = GETDATE()
	PRINT 'LOADING BRONZE LAYER IS COMPLETED'
	PRINT 'Load Duratio for Loading the complete Bronze Layer in Seconds : ' + CAST(DATEDIFF(SECOND, @Batch_start_time,@Batch_end_time) AS NVARCHAR) + 'SECONDS'
	PRINT'-------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
END


--EXEC BRONZE.lOAD_bRONZE


--use sql_warehouse_project
