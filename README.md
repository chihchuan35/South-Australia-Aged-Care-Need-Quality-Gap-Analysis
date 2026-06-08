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

The data used in this project was sourced from **GEN Aged Care Data**.

The datasets cover aged-care users, care needs, provider information, star ratings, staffing minutes, ownership type and care-risk indicators.

## Data Workflow

This project was built using a Microsoft Fabric and Power BI workflow:

1. Source files from GEN Aged Care Data were uploaded into a Microsoft Fabric Lakehouse.
2. Power Query was used to clean and prepare the uploaded data.
3. Cleaned tables were loaded into a Microsoft Fabric Warehouse as the staging / Silver layer.
4. SQL was used to create the final reporting model.
5. The final model was connected to Power BI Desktop using Direct Lake.
6. Power BI was used to build the final dashboard and insight pages.

## Data Model

The final reporting model uses a star schema design.

It includes:

- 2 dimension tables
- 6 fact tables
- 1 dedicated measure table

The model supports analysis across regions, provider types, care needs, service quality, staffing performance and care-risk indicators.

AI-assisted development using MCP was used to accelerate the creation of the star schema and DAX measures. The final model logic, relationships and measures were reviewed and adjusted manually.

## Key Findings

### Demand

South Australia has 44,143 aged-care users, with around 74% concentrated in four metropolitan ACPRs: Metro East, Metro South, Metro West and Metro North.

Care use is mainly driven by home care, which accounts for around 60% of users, followed by permanent residential care at around 37%.

Demand is also deeper in metropolitan areas. Level 3–4 care need shares are highest in Metro South, Metro West and Metro East, meaning these regions carry both higher user volumes and more complex care needs.

### Supply Quality

There are 233 aged-care services in scope, including 209 rated services and 24 unrated services.

The average star rating is 3.67 stars. No rated services sit at 1–2 stars, meaning South Australia does not show an extreme low-quality tail.

The main quality issue is 3-star stagnation. Around 34.4% of rated services remain at the 3-star level, while only 3 services are rated 5 stars.

Government providers record the highest average rating, while Private for Profit providers record the lowest average rating.

### Drivers

Staffing levels are broadly compliant across South Australia. On average, total care minutes exceed the target by 9.5 minutes per resident per day, and 82.7% of services meet their total care-minute target.

However, staffing performance differs by ownership type. Government providers have the largest staffing surplus and highest target attainment rate, while Private for Profit providers operate much closer to the required target.

At the regional level, staffing does not fully explain quality outcomes. Care-risk indicators such as falls, polypharmacy, restrictive practices and antipsychotic use provide additional insight into quality risk.

### Gap Synthesis

The main priority gap appears where high demand overlaps with weaker service quality.

Metro East, Metro South, Metro West and Riverland form the key priority group. Together, these regions account for 27,525 users, or approximately 62% of all aged-care users in South Australia.

Metro East, South and West represent the largest scale priorities due to their high user volumes and deeper care needs.

Riverland represents an acute regional-equity priority because it has the lowest average rating in South Australia and high demand intensity, despite having a smaller population base.

## Recommendation

Prioritise Metro East, South and West for scale impact because these regions combine high aged-care user volumes, high Level 3–4 demand intensity and weaker-than-average quality outcomes.

The main improvement opportunity is to lift 3-star services toward 4-star performance, rather than focus only on extreme low-quality outliers.

Treat Riverland as a targeted regional-equity priority due to its low average rating and high demand intensity.

Quality improvement should focus not only on staffing compliance, but also on care-practice risk indicators such as falls, polypharmacy, restrictive practices and antipsychotic use.

Ownership type should be used as a segmentation lens, particularly when reviewing Private for Profit providers in priority regions.

## Tools Used

- Microsoft Fabric Lakehouse
- Microsoft Fabric Warehouse
- Power Query
- SQL
- Power BI
- Direct Lake
- DAX
- Star schema modelling
- AI-assisted modelling workflow using MCP

## Dashboard Preview

![Dashboard Preview](docs/images/dashboard-preview.png)

## Project Files

- `data/raw/` - raw source files from GEN Aged Care Data
- `reports/` - Power BI report file
- `docs/images/` - dashboard screenshots
- `README.md` - project documentation

## Limitations

This project is descriptive and exploratory.

The analysis identifies patterns and priority areas, but does not claim direct causality between staffing, ownership type, care-risk indicators and star ratings.
