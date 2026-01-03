# PROJECT: E-Commerce Sales Analysis
# DESCRIPTION: SQL-based business analysis project

# 1. CREATE DATABASE

CREATE DATABASE ecommerce_analysis;
SHOW DATABASES;
USE ecommerce_analysis;

# 2. CREATE TABLES
-- customers
-- products
-- orders
-- order_items

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

show tables;

 # 3. INSERT DATA

INSERT INTO customers (customer_id, customer_name, email, signup_date) VALUES
(1, 'Alice Johnson', 'alice@example.com', '2023-01-05'),
(2, 'Bob Smith', 'bob@example.com', '2023-01-10'),
(3, 'Charlie Lee', 'charlie@example.com', '2023-01-18'),
(4, 'Diana Patel', 'diana@example.com', '2023-02-02'),
(5, 'Ethan Brown', 'ethan@example.com', '2023-02-15'),
(6, 'Fatima Khan', 'fatima@example.com', '2023-03-01'),
(7, 'George Miller', 'george@example.com', '2023-03-10'),
(8, 'Hannah Wilson', 'hannah@example.com', '2023-03-18'),
(9, 'Ivan Petrov', 'ivan@example.com', '2023-03-25'),
(10, 'Julia Chen', 'julia@example.com', '2023-04-01');

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99),
(2, 'Bluetooth Headphones', 'Electronics', 79.99),
(3, 'Laptop Stand', 'Accessories', 39.99),
(4, 'USB-C Charger', 'Electronics', 19.99),
(5, 'Office Chair', 'Furniture', 149.99),
(6, 'Notebook Pack', 'Stationery', 9.99),
(7, 'Water Bottle', 'Lifestyle', 14.99),
(8, 'Backpack', 'Accessories', 59.99);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2023-03-01', 105.98),
(102, 2, '2023-03-05', 79.99),
(103, 3, '2023-03-12', 169.98),
(104, 4, '2023-03-20', 59.99),
(105, 5, '2023-04-02', 189.98),
(106, 6, '2023-04-10', 39.99);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 101, 1, 2, 25.99),
(2, 102, 2, 1, 79.99),
(3, 103, 5, 1, 149.99),
(4, 104, 8, 1, 59.99),
(5, 105, 5, 1, 149.99),
(6, 106, 6, 4, 9.99);

select * from customers;
select * from products;
select * from orders;
select * from order_items;

# 4. ANALYSIS QUERIES
#revenue, customers, products, rankings

# Total Revenue
SELECT SUM(total_amount) AS total_revenue
FROM orders;

# Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

# Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

# Monthly Revenue Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m-01') AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

# Top 5 Customers by Spend
SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

# Order Frequency Per Customer
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

# Revenue by Category
SELECT 
    p.category,
    SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

# Top Products
SELECT 
    product_name,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM (
    SELECT 
        p.product_name,
        SUM(oi.quantity * oi.price) AS revenue
    FROM order_items oi
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY p.product_name) t;
    
# Average Order Value (AOV)    
SELECT 
    ROUND(SUM(total_amount) / COUNT(order_id), 2) AS average_order_value
FROM orders;







    
    



   














