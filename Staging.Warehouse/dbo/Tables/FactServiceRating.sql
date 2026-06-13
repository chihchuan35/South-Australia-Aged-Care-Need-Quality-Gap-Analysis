CREATE TABLE [dbo].[FactServiceRating] (

	[service_key] bigint NULL, 
	[region_key] bigint NULL, 
	[overall_rating] bigint NULL, 
	[re_rating] bigint NULL, 
	[compliance_rating] bigint NULL, 
	[staffing_rating] bigint NULL, 
	[qm_rating] bigint NULL, 
	[rn_care_min_target] bigint NULL, 
	[rn_care_min_actual] bigint NULL, 
	[rn_care_min_gap] bigint NULL, 
	[total_care_min_target] bigint NULL, 
	[total_care_min_actual] bigint NULL, 
	[total_care_min_gap] bigint NULL, 
	[qm_pressure_injuries] bigint NULL, 
	[qm_restrictive_practices] bigint NULL, 
	[qm_weight_loss] bigint NULL, 
	[qm_falls] bigint NULL, 
	[qm_major_injury] bigint NULL, 
	[qm_polypharmacy] bigint NULL, 
	[qm_antipsychotic] bigint NULL, 
	[is_unrated] int NOT NULL
);