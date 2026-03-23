## Storage Systems

For the four goals, I would use a combination of storage systems because each workload is different. For readmission risk prediction, the best fit is a data warehouse or lakehouse that stores cleaned historical treatment data in analytics-friendly form. This is where admissions, diagnoses, lab results, medications, procedures, and discharge outcomes can be joined over long time periods. It supports feature engineering and model training far better than a live transactional database.

For doctors asking questions in plain English, I would use two layers. First, a relational OLTP clinical database holds the current structured patient record, such as encounters, diagnoses, procedures, and medication history. Second, a vector database stores embeddings of unstructured doctor notes, discharge summaries, and clinical documents. This allows semantic retrieval when a doctor asks something like “Has this patient had a cardiac event before?” The system can combine vector search with structured record lookup for better accuracy.

For monthly management reports, I would again use the data warehouse or lakehouse. It is ideal for bed occupancy, department-wise costs, utilization, and other reporting because it supports aggregated queries across large historical datasets without slowing down hospital operations.

For real-time ICU vitals, I would use a time-series database. Vitals arrive continuously and at high frequency, so a time-series store is better than a standard relational database for recent telemetry, trend analysis, and efficient retention policies.

## OLTP vs OLAP Boundary

The OLTP boundary ends at systems that support day-to-day hospital operations and direct patient care. This includes the EHR, admissions systems, and the live time-series store used for current ICU monitoring. These systems prioritize fast inserts, updates, and reliable retrieval of the latest patient information.

The OLAP boundary begins once data is extracted, cleaned, and modeled for analysis. The warehouse or lakehouse is the main OLAP layer, because it is designed for historical analysis, monthly reporting, and machine learning workloads. The vector database also sits closer to the analytical side, since it is built for semantic retrieval over indexed document embeddings rather than transaction processing.

## Trade-offs

A major trade-off is architectural complexity. Using a relational database, warehouse, vector database, and time-series database gives better performance for each use case, but it also creates more integration, governance, and synchronization work. To mitigate this, I would use a clear data pipeline with shared patient identifiers, strong metadata standards, and scheduled validation checks so that all systems stay aligned. This keeps the architecture practical while still matching the hospital’s very different data needs.