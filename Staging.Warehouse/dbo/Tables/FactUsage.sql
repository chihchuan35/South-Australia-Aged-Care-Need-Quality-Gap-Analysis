CREATE TABLE [dbo].[FactUsage] (

	[region_key] bigint NULL, 
	[care_type] varchar(8000) NULL, 
	[home_care_level] varchar(8000) NULL, 
	[sex] varchar(8000) NULL, 
	[age_group] varchar(8000) NULL, 
	[indigenous_status] varchar(8000) NULL, 
	[preferred_language] varchar(8000) NULL, 
	[reporting_year] bigint NULL
);