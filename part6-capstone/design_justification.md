## Storage Systems

For predicting patient readmission risk, I rely on a Data Lakehouse as the primary storage layer. Historical treatment data from patient records, medicine logs, and hospital systems is ingested, cleaned, and stored in a columnar format like Parquet. This enables efficient large-scale analytics and model training. The lakehouse supports both batch processing and ML workloads, making it ideal for training predictive models on longitudinal patient data.

For allowing doctors to query patient history in plain English, I use a combination of a transactional database (OLTP) and a Vector Database integrated via a RAG layer. The OLTP system (such as PostgreSQL) stores structured patient records for consistency and fast lookups. In parallel, embeddings of patient notes and medical history are stored in a vector store. This enables semantic search, allowing doctors to ask natural language questions and retrieve contextually relevant information.

For generating monthly reports, I use an OLAP system backed by the lakehouse. Aggregated and transformed data is pushed into OLAP tables optimized for analytical queries. This allows efficient computation of metrics like bed occupancy and department-wise costs. Since these queries are heavy and involve aggregations across time, OLAP ensures performance and scalability.

For streaming and storing real-time ICU vitals, I use a streaming ingestion system feeding into an OLTP store and then into the lakehouse. The OLTP layer handles immediate writes and short-term access for monitoring, while the lakehouse acts as long-term storage for historical analysis and future model training.

## OLTP vs OLAP Boundary

In this architecture, the OLTP layer handles all real-time, transactional operations. This includes patient record updates, ICU vitals ingestion, and operational data required for immediate access. The focus here is on ACID properties, ensuring consistency, reliability, and low-latency writes.

The boundary shifts when data moves into the transformation layer and lakehouse. Once data is cleaned, structured, and stored in analytical formats, it becomes part of the OLAP system. OLAP is used for reporting, trend analysis, and machine learning workloads. It prioritizes read-heavy operations, aggregations, and historical insights over transactional consistency.

The transformation layer acts as the bridge between OLTP and OLAP. It ensures that raw transactional data is converted into analysis-ready formats without impacting operational systems.

## Trade-offs

A key trade-off in this design is the increased system complexity due to maintaining multiple storage systems such as OLTP databases, a lakehouse, and a vector database. While each system is optimized for a specific use case, integrating them introduces operational overhead, data synchronization challenges, and higher infrastructure costs.

To mitigate this, I would standardize data ingestion through a unified pipeline and adopt a lakehouse architecture that supports both analytical and some transactional workloads. Tools that support schema evolution and unified metadata management can reduce friction between systems. Additionally, implementing clear data contracts and monitoring pipelines ensures consistency across layers while keeping the system manageable.