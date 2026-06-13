CREATE TABLE [dbo].[DimRegion] (

	[region_key] bigint NULL, 
	[acpr_code] bigint NULL, 
	[acpr_name] varchar(8000) NULL, 
	[is_metro] int NOT NULL
);