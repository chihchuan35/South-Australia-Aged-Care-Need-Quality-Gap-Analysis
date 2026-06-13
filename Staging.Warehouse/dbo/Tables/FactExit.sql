CREATE TABLE [dbo].[FactExit] (

	[region_key] bigint NULL, 
	[los_days] bigint NULL, 
	[discharge_reason] varchar(8000) NULL, 
	[care_type] varchar(8000) NULL, 
	[sex] varchar(8000) NULL, 
	[age_group] varchar(8000) NULL, 
	[reporting_year] bigint NULL
);