-- part3-datawarehouse/star_schema.sql
-- Star schema for retail transaction reporting
-- Cleanups applied while loading sample data:
-- 1) Mixed date formats standardized to YYYY-MM-DD
-- 2) Category values standardized to: Electronics, Groceries, Clothing
-- 3) Missing store_city values should be filled as 'Unknown' (not needed in these 10 sample facts)

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_number INT NOT NULL,
    month_number INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter_name VARCHAR(2) NOT NULL,
    year_number INT NOT NULL,
    day_name VARCHAR(20) NOT NULL
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(100) NOT NULL
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL UNIQUE,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    units_sold INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    sales_amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- Dimension data: dates
INSERT INTO dim_date (date_id, full_date, day_number, month_number, month_name, quarter_name, year_number, day_name) VALUES
(1, '2023-01-15', 15, 1, 'January', 'Q1', 2023, 'Sunday'),
(2, '2023-02-05', 5, 2, 'February', 'Q1', 2023, 'Sunday'),
(3, '2023-02-20', 20, 2, 'February', 'Q1', 2023, 'Monday'),
(4, '2023-03-31', 31, 3, 'March', 'Q1', 2023, 'Friday'),
(5, '2023-08-09', 9, 8, 'August', 'Q3', 2023, 'Wednesday'),
(6, '2023-08-15', 15, 8, 'August', 'Q3', 2023, 'Tuesday'),
(7, '2023-08-29', 29, 8, 'August', 'Q3', 2023, 'Tuesday'),
(8, '2023-10-26', 26, 10, 'October', 'Q4', 2023, 'Thursday'),
(9, '2023-12-08', 8, 12, 'December', 'Q4', 2023, 'Friday'),
(10, '2023-12-12', 12, 12, 'December', 'Q4', 2023, 'Tuesday');

-- Dimension data: stores
INSERT INTO dim_store (store_id, store_name, store_city) VALUES
(1, 'Bangalore MG', 'Bangalore'),
(2, 'Chennai Anna', 'Chennai'),
(3, 'Delhi South', 'Delhi'),
(4, 'Pune FC Road', 'Pune');

-- Dimension data: products
INSERT INTO dim_product (product_id, product_name, category) VALUES
(1, 'Atta 10kg', 'Groceries'),
(2, 'Biscuits', 'Groceries'),
(3, 'Jeans', 'Clothing'),
(4, 'Phone', 'Electronics'),
(5, 'Smartwatch', 'Electronics'),
(6, 'Speaker', 'Electronics'),
(7, 'Tablet', 'Electronics');

-- Fact data: cleaned sample sales rows (10 rows)
INSERT INTO fact_sales (sales_id, transaction_id, date_id, store_id, product_id, units_sold, unit_price, sales_amount) VALUES
(1, 'TXN5000', 7, 2, 6, 3, 49262.78, 147788.34),
(2, 'TXN5001', 10, 2, 7, 11, 23226.12, 255487.32),
(3, 'TXN5002', 2, 2, 4, 20, 48703.39, 974067.80),
(4, 'TXN5003', 3, 3, 7, 14, 23226.12, 325165.68),
(5, 'TXN5004', 1, 2, 5, 10, 58851.01, 588510.10),
(6, 'TXN5005', 5, 1, 1, 12, 52464.00, 629568.00),
(7, 'TXN5006', 4, 4, 5, 6, 58851.01, 353106.06),
(8, 'TXN5007', 8, 4, 3, 16, 2317.47, 37079.52),
(9, 'TXN5008', 9, 1, 2, 9, 27469.99, 247229.91),
(10, 'TXN5009', 6, 1, 5, 3, 58851.01, 176553.03);