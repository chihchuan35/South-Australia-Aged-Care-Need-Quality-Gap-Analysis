[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Append"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Fabric.Warehouse([CreateNavigationProperties = false]){[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data]{[warehouseId = "f90721ce-d2e4-47c7-8985-760cc02e3e96"]}[Data];
shared silver_homecare_serviceloc = let
  Source = Lakehouse.Contents(null),
  #"Navigation 1" = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  Navigation = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = Navigation{[Name = "GEN-data-People-using-aged-care-by-region-30-June-2025-3-home-care-(service-location).xlsxraw_gen_homecare_region_serviceloc_jun2025.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "Table 3.3 (ACPR)", Kind = "Sheet"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 4", {{"Column1", type text}, {"Column2", type text}}),
  #"Removed top rows" = Table.Skip(#"Changed column type", 2),
  #"Promoted headers" = Table.PromoteHeaders(#"Removed top rows", [PromoteAllScalars = true]),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Promoted headers", {{"ACPR code", Int64.Type}, {"Level 1", Int64.Type}, {"Level 2", Int64.Type}, {"Level 3", Int64.Type}, {"Level 4", Int64.Type}, {"Total", Int64.Type}}),
  #"Removed columns" = Table.RemoveColumns(#"Changed column type 1", {"Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15"})
in
  #"Removed columns";
shared silver_curf_acuity = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "raw_curf_acuity_anacc_2025.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "CURF_PEOPLE_ANACC", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 4", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"YEAR", Int64.Type}, {"STATE", type text}, {"CARE_TYPE", type text}, {"SEX", type text}, {"AGE_GROUP_5", type text}, {"INDIGENOUS_STATUS", type text}, {"PREFERRED_LANGUAGE", type text}, {"COUNTRY_OF_BIRTH", type text}, {"ANACC_CLASSIFICATION", Int64.Type}, {"MOBILITY_CATEGORY", type text}})
in
  #"Changed column type";
shared silver_curf_admission = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "raw_curf_admission_2024_25.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "ADMISSION_CURF", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 4", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"YEAR", Int64.Type}, {"STATE", type text}, {"ACPR_CODE_2018", type text}, {"ACPR_NAME_2018", type text}, {"CARE_TYPE", type text}, {"FIRST_ADMISSION", type text}, {"HOME_CARE_LEVEL", type text}, {"SEX", type text}, {"AGE_GROUP_5", type text}, {"INDIGENOUS_STATUS", type text}, {"PREFERRED_LANGUAGE", type text}, {"COUNTRY_OF_BIRTH", type text}})
in
  #"Changed column type";
shared silver_curf_exit = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "raw_curf_exit_2024_25.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "EXIT_CURF", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 4", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"YEAR", Int64.Type}, {"STATE", type text}, {"ACPR_CODE_2018", type text}, {"ACPR_NAME_2018", type text}, {"CARE_TYPE", type text}, {"LOS_DAYS", Int64.Type}, {"LOS_MONTHS", type number}, {"DISCHARGE_REASON", type text}, {"SEX", type text}, {"AGE_GROUP_5", type text}, {"INDIGENOUS_STATUS", type text}, {"PREFERRED_LANGUAGE", type text}, {"COUNTRY_OF_BIRTH", type text}})
in
  #"Changed column type";
shared silver_curf_people = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "raw_curf_people_2025.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "PEOPLE_CURF", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 4", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"YEAR", Int64.Type}, {"STATE", type text}, {"ACPR_CODE_2018", type text}, {"ACPR_NAME_2018", type text}, {"CARE_TYPE", type text}, {"HOME_CARE_LEVEL", type text}, {"SEX", type text}, {"AGE_GROUP_5", type text}, {"INDIGENOUS_STATUS", type text}, {"PREFERRED_LANGUAGE", type text}, {"COUNTRY_OF_BIRTH", type text}})
in
  #"Changed column type";
shared silver_curf_service = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "raw_curf_service_2025.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "SERVICE_CURF", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 4", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"YEAR", Int64.Type}, {"STATE", type text}, {"ACPR_CODE_2018", Int64.Type}, {"ACPR_NAME_2018", type text}, {"RA_NAME_2016", type text}, {"MMM_CODE_2019", Int64.Type}, {"MMM_NAME_2019", type text}, {"PROGRAM_TYPE", type text}, {"ORGANISATION_TYPE", type text}, {"SERVICE_SIZE", type text}, {"OPERATIONAL_PLACES", type text}})
in
  #"Changed column type";
shared silver_homecare_recipientloc = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "raw_gen_homecare_region_recipientloc_jun2025.xlsxraw_gen_homecare_region_recipientloc_jun2025.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "Table 2.3 (ACPR)", Kind = "Sheet"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 4", {{"Column1", type text}, {"Column2", type text}}),
  #"Removed top rows" = Table.Skip(#"Changed column type", 2),
  #"Removed columns" = Table.RemoveColumns(#"Removed top rows", {"Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15"}),
  #"Promoted headers" = Table.PromoteHeaders(#"Removed columns", [PromoteAllScalars = true]),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Promoted headers", {{"ACPR (2018) code", Int64.Type}, {"Level 1", Int64.Type}, {"Level 2", Int64.Type}, {"Level 3", Int64.Type}, {"Level 4", Int64.Type}, {"Total", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type 1", {{"ACPR (2018) code", "ACPR code"}, {"ACPR (2018) name", "ACPR name"}})
in
  #"Renamed columns";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "silver_starratings_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "service_name", DestinationColumnName = "service_name"], [SourceColumnName = "provider_name", DestinationColumnName = "provider_name"], [SourceColumnName = "service_suburb", DestinationColumnName = "service_suburb"], [SourceColumnName = "ownership", DestinationColumnName = "ownership"], [SourceColumnName = "acpr_name", DestinationColumnName = "acpr_name"], [SourceColumnName = "state", DestinationColumnName = "state"], [SourceColumnName = "mmm_region", DestinationColumnName = "mmm_region"], [SourceColumnName = "mmm_code", DestinationColumnName = "mmm_code"], [SourceColumnName = "size", DestinationColumnName = "size"], [SourceColumnName = "overall_rating", DestinationColumnName = "overall_rating"], [SourceColumnName = "re_rating", DestinationColumnName = "re_rating"], [SourceColumnName = "compliance_rating", DestinationColumnName = "compliance_rating"], [SourceColumnName = "staffing_rating", DestinationColumnName = "staffing_rating"], [SourceColumnName = "rn_care_min_target", DestinationColumnName = "rn_care_min_target"], [SourceColumnName = "rn_care_min_actual", DestinationColumnName = "rn_care_min_actual"], [SourceColumnName = "total_care_min_target", DestinationColumnName = "total_care_min_target"], [SourceColumnName = "total_care_min_actual", DestinationColumnName = "total_care_min_actual"], [SourceColumnName = "qm_rating", DestinationColumnName = "qm_rating"], [SourceColumnName = "qm_pressure_injuries", DestinationColumnName = "qm_pressure_injuries"], [SourceColumnName = "qm_restrictive_practices", DestinationColumnName = "qm_restrictive_practices"], [SourceColumnName = "qm_weight_loss", DestinationColumnName = "qm_weight_loss"], [SourceColumnName = "qm_falls", DestinationColumnName = "qm_falls"], [SourceColumnName = "qm_major_injury", DestinationColumnName = "qm_major_injury"], [SourceColumnName = "qm_polypharmacy", DestinationColumnName = "qm_polypharmacy"], [SourceColumnName = "qm_antipsychotic", DestinationColumnName = "qm_antipsychotic"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared silver_starratings = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "d14c2a4b-ab69-4b61-8f1b-eb0217100713"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "b40b03c5-e233-4fe7-8d97-ba9a12092beb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "raw_starratings_may2026.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 3", null, true),
  #"Navigation 4" = #"Imported Excel workbook"{[Item = "Detailed data", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 4", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Reporting Period", type date}, {"Service Name", type text}, {"Provider Name", type text}, {"Service Suburb", type text}, {"Purpose", type text}, {"Aged Care Planning Region", type text}, {"State/Territory", type text}, {"MMM Region", type text}, {"MMM Code", type text}, {"Size", type text}, {"Overall Star Rating", Int64.Type}, {"Residents' Experience rating", Int64.Type}, {"[RE] Interview Year", Int64.Type}, {"[RE] Food - Always", Int64.Type}, {"[RE] Food - Most of the time", Int64.Type}, {"[RE] Food - Some of the time", Int64.Type}, {"[RE] Food - Never", Int64.Type}, {"[RE] Safety - Always", Int64.Type}, {"[RE] Safety - Most of the time", Int64.Type}, {"[RE] Safety - Some of the time", Int64.Type}, {"[RE] Safety - Never", Int64.Type}, {"[RE] Operation - Always", Int64.Type}, {"[RE] Operation - Most of the time", Int64.Type}, {"[RE] Operation - Some of the time", Int64.Type}, {"[RE] Operation - Never", Int64.Type}, {"[RE] Care Need - Always", Int64.Type}, {"[RE] Care Need - Most of the time", Int64.Type}, {"[RE] Care Need - Some of the time", Int64.Type}, {"[RE] Care Need - Never", Int64.Type}, {"[RE] Competent - Always", Int64.Type}, {"[RE] Competent - Most of the time", Int64.Type}, {"[RE] Competent - Some of the time", Int64.Type}, {"[RE] Competent - Never", Int64.Type}, {"[RE] Independent - Always", Int64.Type}, {"[RE] Independent - Most of the time", Int64.Type}, {"[RE] Independent - Some of the time", Int64.Type}, {"[RE] Independent - Never", Int64.Type}, {"[RE] Explain - Always", Int64.Type}, {"[RE] Explain - Most of the time", Int64.Type}, {"[RE] Explain - Some of the time", Int64.Type}, {"[RE] Explain - Never", Int64.Type}, {"[RE] Respect - Always", Int64.Type}, {"[RE] Respect - Most of the time", Int64.Type}, {"[RE] Respect - Some of the time", Int64.Type}, {"[RE] Respect - Never", Int64.Type}, {"[RE] Follow Up - Always", Int64.Type}, {"[RE] Follow Up - Most of the time", Int64.Type}, {"[RE] Follow Up - Some of the time", Int64.Type}, {"[RE] Follow Up - Never", Int64.Type}, {"[RE] Caring - Always", Int64.Type}, {"[RE] Caring - Most of the time", Int64.Type}, {"[RE] Caring - Some of the time", Int64.Type}, {"[RE] Caring - Never", Int64.Type}, {"[RE] Voice - Always", Int64.Type}, {"[RE] Voice - Most of the time", Int64.Type}, {"[RE] Voice - Some of the time", Int64.Type}, {"[RE] Voice - Never", Int64.Type}, {"[RE] Home - Always", Int64.Type}, {"[RE] Home - Most of the time", Int64.Type}, {"[RE] Home - Some of the time", Int64.Type}, {"[RE] Home - Never", Int64.Type}, {"Compliance rating", Int64.Type}, {"[C] Decision type", type text}, {"[C] Date Decision Applied", type date}, {"[C] Date Decision Ends", type date}, {"[C] Compliance Rating Reason", type text}, {"Staffing rating", Int64.Type}, {"[S] Registered Nurse Care Minutes - Target", Int64.Type}, {"[S] Registered Nurse Care Minutes - Actual", Int64.Type}, {"[S] Total Care Minutes - Target", Int64.Type}, {"[S] Total Care Minutes - Actual", Int64.Type}, {"Quality Measures rating", Int64.Type}, {"[QM] Pressure injuries*", Int64.Type}, {"[QM] Restrictive practices", Int64.Type}, {"[QM] Unplanned weight loss*", Int64.Type}, {"[QM] Falls and major injury - falls*", Int64.Type}, {"[QM] Falls and major injury - major injury from a fall*", Int64.Type}, {"[QM] Medication management - polypharmacy", Int64.Type}, {"[QM] Medication management - antipsychotic", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Service Name", "service_name"}, {"Provider Name", "provider_name"}, {"Service Suburb", "service_suburb"}, {"Purpose", "ownership"}, {"Aged Care Planning Region", "acpr_name"}, {"State/Territory", "state"}, {"MMM Region", "mmm_region"}, {"MMM Code", "mmm_code"}, {"Size", "size"}}),
  #"Removed columns" = Table.RemoveColumns(#"Renamed columns", {"Reporting Period"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns", {{"Overall Star Rating", "overall_rating"}, {"Residents' Experience rating", "re_rating"}, {"Compliance rating", "compliance_rating"}, {"Staffing rating", "staffing_rating"}, {"Quality Measures rating", "qm_rating"}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Renamed columns 1", {"[RE] Interview Year", "[RE] Food - Always", "[RE] Food - Most of the time", "[RE] Food - Some of the time", "[RE] Food - Never", "[RE] Safety - Always", "[RE] Safety - Most of the time", "[RE] Safety - Some of the time", "[RE] Safety - Never", "[RE] Operation - Always", "[RE] Operation - Most of the time", "[RE] Operation - Some of the time", "[RE] Operation - Never", "[RE] Care Need - Always", "[RE] Care Need - Most of the time", "[RE] Care Need - Some of the time", "[RE] Care Need - Never", "[RE] Competent - Always", "[RE] Competent - Most of the time", "[RE] Competent - Some of the time", "[RE] Competent - Never", "[RE] Independent - Always", "[RE] Independent - Most of the time", "[RE] Independent - Some of the time", "[RE] Independent - Never", "[RE] Explain - Always", "[RE] Explain - Most of the time", "[RE] Explain - Some of the time", "[RE] Explain - Never", "[RE] Respect - Always", "[RE] Respect - Most of the time", "[RE] Respect - Some of the time", "[RE] Respect - Never", "[RE] Follow Up - Always", "[RE] Follow Up - Most of the time", "[RE] Follow Up - Some of the time", "[RE] Follow Up - Never", "[RE] Caring - Always", "[RE] Caring - Most of the time", "[RE] Caring - Some of the time", "[RE] Caring - Never", "[RE] Voice - Always", "[RE] Voice - Most of the time", "[RE] Voice - Some of the time", "[RE] Voice - Never", "[RE] Home - Always", "[RE] Home - Most of the time", "[RE] Home - Some of the time", "[RE] Home - Never", "[C] Decision type", "[C] Date Decision Applied", "[C] Date Decision Ends", "[C] Compliance Rating Reason", "[C] Date Audit Closed", "[C] Standard 1: The individual", "[C] Standard 2: The organisation", "[C] Standard 3: The care and services", "[C] Standard 4: The environment", "[C] Standard 5: Clinical care", "[C] Standard 6: Food and nutrition", "[C] Standard 7: The residential community"}),
  #"Renamed columns 2" = Table.RenameColumns(#"Removed columns 1", {{"[QM] Pressure injuries*", "qm_pressure_injuries"}, {"[QM] Restrictive practices", "qm_restrictive_practices"}, {"[QM] Unplanned weight loss*", "qm_weight_loss"}, {"[QM] Falls and major injury - falls*", "qm_falls"}, {"[QM] Falls and major injury - major injury from a fall*", "qm_major_injury"}, {"[QM] Medication management - polypharmacy", "qm_polypharmacy"}, {"[QM] Medication management - antipsychotic", "qm_antipsychotic"}, {"[S] Registered Nurse Care Minutes - Target", "rn_care_min_target"}, {"[S] Registered Nurse Care Minutes - Actual", "rn_care_min_actual"}, {"[S] Total Care Minutes - Target", "total_care_min_target"}, {"[S] Total Care Minutes - Actual", "total_care_min_actual"}})
in
  #"Renamed columns 2";
shared silver_starratings_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Staging"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "silver_starratings"]}?[Data]?
in
  TableNavigation;
