# South Australia Aged Care Need–Quality Gap Analysis

## Project Overview

This project analyses aged-care demand, service quality, staffing, ownership type and care-risk indicators across South Australia.

The main objective is to identify where aged-care improvement efforts should be prioritised by comparing regional demand intensity with service quality outcomes.

The project focuses on five key questions:

1. Where is aged-care demand concentrated?
2. Where is demand more complex or high-care?
3. Where is supply quality weaker?
4. What explains the gap: staffing, ownership, care incidents, or a mix?
5. Which regions should be prioritised first?

## Data Source

This project combines two official sources:

- **AIHW GEN Aged Care Data** – aged-care usage, care needs, admissions, separations, providers, and home-care packages by region.
- **Star Ratings Quarterly Data Extract – May 2026** – service star ratings, sub-ratings, care-minute targets/actuals, and quality / care-risk indicators.

The two sources are reported at different granularities and were bridged on the **Aged Care Planning Region (ACPR, 2018)**.

## Data Workflow

This project was built end-to-end in Microsoft Fabric and Power BI, following a medallion (Bronze → Silver → Gold) pattern:

1. **Bronze** – source files from both datasets were uploaded into a Microsoft Fabric Lakehouse.
2. **Clean** – Dataflow Gen2 (Power Query) was used to clean and prepare the uploaded data.
3. **Silver** – cleaned tables were loaded into a Microsoft Fabric Warehouse as the staging layer.
4. **Gold** – T-SQL was used to build the final star-schema reporting model.
5. The Gold model was connected to a Power BI semantic model using **Direct Lake**.
6. Power BI was used to build the final dashboard and insight pages.

Regional results are shown on **paired choropleth maps** — care users by region and average star rating by region — built with the Shape map visual and a custom ACPR (2018) **TopoJSON** boundary file. ACPR is a non-standard geography that Power BI cannot geocode automatically, so the official Department of Health planning-region shapefile was converted to TopoJSON (with mapshaper) and matched to `DimRegion` on the ACPR name. The maps use sentence-mode tooltips and a per-visual calculation that shows each region's share of total users. Side by side they make the core gap visible at a glance: demand concentrates in the metropolitan regions, while the highest ratings sit in the low-population outback.

## Data Model

The final reporting model uses a star schema with `DimRegion` as the central hub.

It includes:

- **2 connected dimension tables** – `DimRegion`, `DimService`
- **1 disconnected dimension table** – `DimQM`, used with a `SWITCH` measure to drive the quality-measure profile chart
- **6 fact tables** – `FactServiceRating`, `FactUsage`, `FactAdmission`, `FactExit`, `FactHomeCareByRegion`, and `FactAcuity` (intentionally unrelated, state grain only)
- **1 dedicated measures table** – `_Measures`

The model supports analysis across regions, provider types, care needs, service quality, staffing performance and care-risk indicators.

AI-assisted development using an MCP server (Power BI Modeling MCP) was used to accelerate the creation of the star-schema relationships and DAX measures. All relationships, measures and model logic were then reviewed and adjusted manually.

## Methodology / Data Modelling Notes

**Geographic bridge.** The three data worlds (usage/demand, home-care-by-region, and star ratings) share no common service identifier, so the **Aged Care Planning Region (ACPR, 2018)** is used as the single geographic key across all sources and as the grain of `DimRegion` (11 SA ACPRs).

**Join strategy varies by source.** ACPR _names are not unique across states_, and the ACPR _code is stored inconsistently_ (text in the usage data, numeric in the home-care files). Joins therefore use **ACPR name + a `STATE = 'SA'` filter** for the usage/CURF facts, and the **numeric ACPR code** for the home-care facts, to avoid cross-state mismatches.

**SA scoping in the data layer.** South Australia is filtered in SQL (Gold layer) via an inner join to `DimRegion`, keeping the Silver layer generic and reusable.

**Modelling choices.** MMM (remoteness) is treated as a service-level attribute (one ACPR spans several MMM values). Acuity (ANACC) exists only at state level, so it is used as SA-wide background context rather than a regional axis. A **disconnected `DimQM` table + a `SWITCH` measure** power the quality-measure profile chart (overcoming the multi-measure visual limitation), and `FactAcuity` is intentionally left unrelated (state grain only). The priority quadrant uses **two transparent axes (need depth × quality) rather than a composite index**, so the prioritisation logic stays fully explainable.

**Measure validation.** Distribution sanity-checks surfaced a DAX issue where `BLANK()` is treated as 0 in comparisons, which inflated "% below 3 stars" and "% meeting care-minute target" by counting unrated / no-data services. Both measures were corrected with explicit `NOT ISBLANK()` guards.

**Model validation (Tabular Editor).** The model was run through Tabular Editor's Best Practice Analyzer. Object descriptions were added, the measures-table placeholder column was optimised, and the intentional design choices (the three disconnected tables `FactAcuity` / `_Measures` / `DimQM`, and the absence of a date table for a cross-sectional snapshot) were reviewed and annotated as ignored rather than auto-fixed.

## Source Control

The entire Fabric workspace — lakehouses, warehouse, dataflow, pipeline, and the `SA_AgedCare_Gap` semantic model — is version-controlled via Fabric Git integration (GitHub). The serialised item definitions (TMDL) live on the `GitHub-Health` branch, which makes the model diff-able (relationships and measures are plain text) and the project reproducible.

## Key Findings

### Demand

South Australia has 44,143 aged-care users, with around 74% concentrated in four metropolitan ACPRs: Metro East, Metro South, Metro West and Metro North.

Care use is mainly driven by home care, which accounts for around 60% of users, followed by permanent residential care at around 37%.

Demand is also deeper in metropolitan areas. Level 3–4 care-need shares are highest in Metro South, Metro West and Metro East, meaning these regions carry both higher user volumes and more complex care needs.

### Supply Quality

There are 233 aged-care services in scope, including 209 rated services and 24 unrated services.

The average star rating is 3.67 stars. No rated services sit at 1–2 stars, meaning South Australia does not show an extreme low-quality tail.

The main quality issue is 3-star stagnation. Around 34.4% of rated services remain at the 3-star level, while only 3 services are rated 5 stars.

Government providers record the highest average rating, while Private for Profit providers record the lowest average rating.

### Drivers

Staffing levels are broadly compliant across South Australia. On average, total care minutes exceed the target by 9.5 minutes per resident per day, and 82.7% of services meet their total care-minute target.

However, staffing performance differs sharply by ownership type. Government providers run the largest surplus and meet the total care-minute target in 95.7% of services, whereas Private for Profit providers have the lowest attainment at 76.6%, running closest to (and least often above) the minimum.

At the regional level, staffing does not fully explain quality outcomes. Care-risk indicators add further nuance: falls (33%) and polypharmacy (33%) are the most prevalent adverse events, followed by restrictive practices (22%) and antipsychotic use (10%). These care-practice indicators describe quality risk that staffing levels alone do not capture.

### Gap Synthesis

The main priority gap appears where high demand overlaps with weaker service quality.

Metro East, Metro South, Metro West and Riverland form the key priority group. Together, these regions account for 27,525 users, or approximately 62% of all aged-care users in South Australia.

Metro East, South and West represent the largest-scale priorities due to their high user volumes and deeper care needs.

Riverland represents an acute regional-equity priority because it has the lowest average rating in South Australia and high demand intensity, despite having a smaller population base.

## Recommendation

Prioritise Metro East, South and West for scale impact, because these regions combine high aged-care user volumes, high Level 3–4 demand intensity and weaker-than-average quality outcomes.

The main improvement opportunity is to lift 3-star services toward 4-star performance, rather than focus only on extreme low-quality outliers.

Treat Riverland as a targeted regional-equity priority due to its low average rating and high demand intensity.

Quality improvement should focus not only on staffing compliance, but also on care-practice risk indicators such as falls, polypharmacy, restrictive practices and antipsychotic use.

Use ownership type as a segmentation lens: Private for Profit services warrant the closest review in priority regions, as they show the lowest care-minute target attainment (76.6%, vs 95.7% for Government).

## Tools Used

- Microsoft Fabric Lakehouse
- Microsoft Fabric Warehouse
- Dataflow Gen2 / Power Query
- T-SQL
- Power BI (Direct Lake semantic model)
- DAX
- Star-schema modelling
- AI-assisted modelling workflow using an MCP server (Power BI Modeling MCP)
- Tabular Editor (Best Practice Analyzer)
- mapshaper + custom TopoJSON (choropleth boundaries)
- Fabric Git integration (GitHub) for source control

## Project Files

- `data/raw/` – raw source files (AIHW GEN and Star Ratings extracts)
- `gold_build.sql` – T-SQL that builds the Gold star schema
- `geo/SA_ACPR.json` – custom ACPR (2018) TopoJSON used by the choropleth
- `reports/` – Power BI report file
- `docs/images/` – dashboard screenshots
- `README.md` – project documentation
- `GitHub-Health` branch – serialised Fabric item definitions (TMDL) under Git integration

## Limitations

This project is descriptive and exploratory. It identifies patterns and priority areas but does not claim causality between staffing, ownership type, care-risk indicators and star ratings.

- **Cross-sectional**: the Star Ratings data is a single May 2026 snapshot, so no trends over time are inferred.
- **Ecological (region-level)**: regional patterns should not be read as conclusions about individual services.
- **Proxy for need depth**: regional need depth is proxied by the home-care Level 3–4 share, as service-level acuity (ANACC) is only available at state level.
- **Coverage**: rating and quality analysis covers the 209 rated services (~90%); 24 unrated services are excluded from quality measures and reported separately.
- **Unweighted averages**: ratings and quality measures are service-level averages (each service weighted equally), not population-weighted.
- **Staffing is necessary but not sufficient**: care minutes are largely met and, at the regional level, do not strongly predict ratings.
