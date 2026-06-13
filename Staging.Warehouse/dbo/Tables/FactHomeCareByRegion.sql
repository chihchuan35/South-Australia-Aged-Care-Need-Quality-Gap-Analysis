CREATE TABLE [dbo].[FactHomeCareByRegion] (

	[region_key] bigint NULL, 
	[location_basis] varchar(9) NOT NULL, 
	[level1] bigint NULL, 
	[level2] bigint NULL, 
	[level3] bigint NULL, 
	[level4] bigint NULL, 
	[total] bigint NULL, 
	[level34_share] float NULL
);