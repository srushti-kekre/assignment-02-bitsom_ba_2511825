-- 3NF schema for orders_flat.csv
-- This design removes repeated customer, product, and sales-rep attributes from the order rows,
-- eliminating the insert, update, and delete anomalies seen in the flat file.

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS sales_reps;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(255) NOT NULL UNIQUE,
    customer_city VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0)
);

CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(255) NOT NULL UNIQUE,
    office_address VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    sales_rep_id VARCHAR(10) NOT NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_orders_sales_rep FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

-- Insert data into customers (as present in source file)
INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
    ('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
    ('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
    ('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
    ('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
    ('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
    ('C006', 'Neha Gupta', 'neha@gmail.com', 'Delhi'),
    ('C007', 'Arjun Nair', 'arjun@gmail.com', 'Bangalore'),
    ('C008', 'Kavya Rao', 'kavya@gmail.com', 'Hyderabad');

-- Insert data into products (as present in source file)
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
    ('P001', 'Laptop', 'Electronics', 55000.00),
    ('P002', 'Mouse', 'Electronics', 800.00),
    ('P003', 'Desk Chair', 'Furniture', 8500.00),
    ('P004', 'Notebook', 'Stationery', 120.00),
    ('P005', 'Headphones', 'Electronics', 3200.00),
    ('P006', 'Standing Desk', 'Furniture', 22000.00),
    ('P007', 'Pen Set', 'Stationery', 250.00),
    ('P008', 'Webcam', 'Electronics', 2100.00);

-- Insert data into sales_reps (as present in source file)
INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
    ('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
    ('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place, New Delhi - 110001'),
    ('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road, Bangalore - 560001');

-- Insert data into orders (10 sample orders)
INSERT INTO orders (order_id, order_date, customer_id, product_id, quantity, sales_rep_id) VALUES
    ('ORD1000', '2023-05-21', 'C002', 'P001', '2', 'SR03'),
    ('ORD1001', '2023-02-22', 'C004', 'P002', '5', 'SR03'),
    ('ORD1002', '2023-01-17', 'C002', 'P005', '1', 'SR02'),
    ('ORD1003', '2023-09-16', 'C002', 'P002', '5', 'SR01'),
    ('ORD1004', '2023-11-29', 'C001', 'P005', '5', 'SR01'),
    ('ORD1005', '2023-10-29', 'C007', 'P002', '3', 'SR02'),
    ('ORD1006', '2023-12-24', 'C001', 'P007', '4', 'SR01'),
    ('ORD1007', '2023-04-21', 'C006', 'P003', '3', 'SR01'),
    ('ORD1008', '2023-02-19', 'C002', 'P001', '3', 'SR02'),
    ('ORD1009', '2023-01-23', 'C006', 'P005', '4', 'SR02'),
    ('ORD1010', '2023-10-10', 'C002', 'P004', '3', 'SR01'),
    ('ORD1011', '2023-12-27', 'C006', 'P005', '1', 'SR01');
