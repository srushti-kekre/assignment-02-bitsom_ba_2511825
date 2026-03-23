## ETL Decisions
Decision 1 — Date Format Standardization

Problem: The raw dataset had multiple date formats such as "12/01/24", "2024-01-12", and "12-01-2024". This inconsistency makes it difficult to group data by month or year and can lead to incorrect analysis.

Resolution: All date values were converted into a standard format of YYYY-MM-DD before loading into the warehouse. This ensures consistency and allows reliable aggregation for monthly and yearly reporting.

Decision 2 — Category and Store Name Normalization

Problem: Product categories and store names appeared in different formats such as "electronics", "Electronics", "ELECTRONICS" and "Store A", "store a". This would create duplicate entries in dimension tables and result in incorrect grouping during analysis.

Resolution: All categorical values were standardized to a consistent uppercase format. For example, all variations of electronics were converted to "ELECTRONICS" and store names were unified as "STORE_A". This ensures accurate grouping and avoids duplication.

Decision 3 — Handling Missing Values

Problem: Some records had missing values in fields like city or category. Leaving these as NULL could cause issues during joins and reporting, especially when grouping data.

Resolution: Missing values were replaced with a default value such as "UNKNOWN". This ensures that all records remain usable and no data is lost during aggregation or reporting.