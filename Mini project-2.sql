create database Electornics;
use Electornics;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Ravi', 'Hyderabad'),
(2, 'Anita', 'Bangalore'),
(3, 'Kiran', 'Chennai'),
(4, 'Sneha', 'Mumbai'),
(5, 'Mani', 'Kurnool'),
(6, 'Arul', 'Tirupati'),
(7, 'Heamanth', 'Venkatagiri'),
(8, 'Monish', 'Kerala'),
(9, 'Habi', 'Odisha'),
(10, 'Arjun', 'Delhi');

INSERT INTO products VALUES
(101, 'Laptop', 60000),
(102, 'Mobile', 20000),
(103, 'Headphones', 2000),
(104, 'Keyboard', 1500),
(105, 'Mouse', 800),
(106, 'Tablet', 30000),
(107, 'Monitor', 12000),
(108, 'Printer', 15000),
(109, 'Speaker', 5000),
(110, 'Webcam', 2500);

INSERT INTO orders VALUES
(1, 1, 101, '2024-01-10', 1, 60000),
(2, 2, 102, '2024-01-15', 2, 40000),
(3, 1, 103, '2024-02-05', 3, 6000),
(4, 3, 101, '2024-02-20', 1, 60000),
(5, 4, 104, '2024-03-01', 2, 3000),
(6, 5, 105, '2024-03-10', 5, 4000),
(7, 2, 101, '2024-03-15', 1, 60000),
(8, 3, 102, '2024-04-01', 1, 20000),
(9, 6, 106, '2024-04-05', 1, 30000),
(10, 7, 107, '2024-04-10', 2, 24000),
(11, 8, 108, '2024-04-12', 1, 15000),
(12, 9, 109, '2024-04-15', 3, 15000),
(13, 10, 110, '2024-04-18', 2, 5000),
(14, 6, 101, '2024-05-01', 1, 60000),
(15, 7, 102, '2024-05-03', 1, 20000),
(16, 8, 103, '2024-05-05', 4, 8000),
(17, 9, 104, '2024-05-07', 2, 3000),
(18, 10, 105, '2024-05-10', 6, 4800),
(19, 1, 106, '2024-05-12', 1, 30000),
(20, 2, 107, '2024-05-15', 1, 12000),
(21, 3, 108, '2024-05-18', 2, 30000),
(22, 4, 109, '2024-05-20', 1, 5000),
(23, 5, 110, '2024-05-22', 3, 7500);


-- Total Revenue
SELECT SUM(amount) AS total_revenue FROM orders;

-- Top Customers
SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;

-- Monthly Trends
SELECT MONTH(order_date) AS month, SUM(amount) AS revenue
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;

-- Best Selling Product
SELECT p.product_name, COUNT(*) AS total_orders
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC
LIMIT 1;

-- Customer Purchase History
SELECT c.name, p.product_name, o.amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;


-- GROUP BY 
-- 1. Total Revenue per customer
SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

--  Revenue Per City
SELECT c.city, SUM(o.amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

-- Product-Wise Sales
SELECT p.product_name, SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

-- Order per Month
SELECT MONTH(order_date) AS month, COUNT(*) AS total_orders
FROM orders
GROUP BY MONTH(order_date);

-- Customers with High Spending
SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING SUM(o.amount) > 50000;

-- Index Queries

-- Create Index on order Table
CREATE INDEX idx_customer_id ON orders(customer_id);

-- index on date
CREATE INDEX idx_order_date ON orders(order_date);

-- composite index
CREATE INDEX idx_customer_date 
ON orders(customer_id, order_date);

-- Stored procedures

-- Get Customer Order
DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT *
    FROM orders
    WHERE customer_id = cust_id;
END //

DELIMITER ;

CALL GetCustomerOrders(1);

-- Monthly Revenue
DELIMITER //

CREATE PROCEDURE MonthlyRevenue()
BEGIN
    SELECT MONTH(order_date) AS month,
           SUM(amount) AS revenue
    FROM orders
    GROUP BY MONTH(order_date);
END //

DELIMITER ;

-- Insert order
DELIMITER //

CREATE PROCEDURE AddOrder(
    IN oid INT,
    IN cid INT,
    IN pid INT,
    IN odate DATE,
    IN qty INT,
    IN amt DECIMAL(10,2)
)
BEGIN
    INSERT INTO orders
    VALUES (oid, cid, pid, odate, qty, amt);
END //

DELIMITER ;



-- Transactions 

-- Basic transactions
START TRANSACTION;

INSERT INTO orders VALUES (30, 1, 101, '2024-06-01', 1, 60000);

COMMIT;


-- Place order + Reduce Stock
START TRANSACTION;

INSERT INTO orders VALUES (31, 2, 102, '2024-06-02', 1, 20000);

UPDATE products
SET price = price - 1000
WHERE product_id = 102;

COMMIT;





