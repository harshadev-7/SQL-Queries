# Bookstore Project Summary

## Overview
This SQL project implements a **Bookstore Management System** with a complete database schema for managing customers, books, orders, and order details.

---

## Database Schema

### Tables Present

| Table | Primary Key | Description |
|-------|-------------|-------------|
| `customers` | `customer_id` | Stores customer information (name, email, city) |
| `books` | `book_id` | Stores book inventory (title, author, price, stock) |
| `orders` | `order_id` | Stores order headers with customer and date info |
| `order_details` | `order_detail_id` | Stores individual line items per order |

---

## Entity-Relationship (ER) Model

```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   CUSTOMERS    │       │     ORDERS      │       │  ORDER_DETAILS │       │     BOOKS      │
├─────────────────┤       ├─────────────────┤       ├─────────────────┤       ├─────────────────┤
│ customer_id (PK)│◄──────│ customer_id (FK)│       │ order_id (FK)  │──────►│ order_id (PK)   │
│ name            │       │ order_id (PK)   │◄──────│ book_id (FK)    │       │ book_id (PK)    │
│ email           │       │ order_date      │       │ quantity        │       │ title           │
│ city            │       │ customer_id (FK)│       │ order_detail_id│       │ author          │
└─────────────────┘       └─────────────────┘       └─────────────────┘       │ price           │
       │                              │                      │                 │ stock          │
       │                              │                      │                 └─────────────────┘
       │                              │                      │
       └─────────────────────────────┴──────────────────────┘
```

### Relationship Details

| Table 1 | Relationship | Table 2 | Description |
|---------|--------------|---------|-------------|
| `customers` | 1:N | `orders` | One customer can place many orders |
| `orders` | 1:N | `order_details` | One order can have many line items |
| `books` | 1:N | `order_details` | One book can appear in many order details |

### Key Constraints

- **Primary Keys**: `customer_id`, `book_id`, `order_id`, `order_detail_id`
- **Foreign Keys**: 
  - `orders.customer_id` → `customers.customer_id`
  - `order_details.order_id` → `orders.order_id`
  - `order_details.book_id` → `books.book_id`

---

## Queries Used - Category Breakdown

### 1. Basic Queries
- `SELECT *` - Retrieve all records from a table
- `SELECT` with specific columns

### 2. JOIN Queries
- **INNER JOIN** - Get orders with customer names and book titles
- **LEFT JOIN** - Find customers who never placed orders
- **LEFT JOIN** - Find books that were never ordered

### 3. Subqueries
- Find customers who placed an order
- Find books with price higher than average

### 4. Aggregate Functions
| Function | Usage |
|----------|-------|
| `SUM()` | Total sales per book, total money spent by customers |
| `COUNT()` | Total orders per customer |
| `AVG()` | Average book price |

### 5. Group By & Having
- `GROUP BY` - Group data by customer, book, or order
- `HAVING` - Filter grouped data (e.g., revenue > 1500)

### 6. Stored Procedures
- `get_orders()` - Get all orders for a customer
- `get_all_orders()` - Retrieve orders by customer ID
- `get_total_price()` - Calculate total sales (OUT parameter)
- `insert_newcust()` - Insert new customer record

### 7. Transactions
- `START TRANSACTION` - Begin transaction block
- `COMMIT` - Save changes permanently
- `ROLLBACK` - Undo changes (demonstrated)

### 8. Index Operations
- `CREATE INDEX` - Create index on book_id and title
- `DROP INDEX` - Remove index
- `SHOW INDEXES` - Display indexes

---

## Data Summary

### Customers: **20** records
- Cities covered: Nellore, Hyderabad, Tirupati, Mumbai, Delhi, Kolkata, Jaipur, Chandigarh, Noida, Lucknow, Vizag, Indore, Bhopal, Nagpur, Surat, Coimbatore

### Books: **13** records
- Price range: ₹400 - ₹1000
- Topics: SQL, MySQL, Oracle, PostgreSQL, NoSQL, MongoDB, Database Design

### Orders: **20** records
- Date range: March 20-30, 2026

### Order Details: **21** records
- Each order links to specific books with quantities

---

## Key Analytics Queries

1. **Total sales per book** - Revenue by title
2. **Customer spending** - Total money spent by each customer
3. **Top selling book** - Book with highest revenue
4. **Order frequency** - Orders per customer
5. **High-value customers** - Customers with >1 order
6. **Best-selling quantities** - Books sold >3 units
7. **Revenue thresholds** - Books generating >₹1500

---

## Technologies Demonstrated

- ✅ Database Creation & Selection
- ✅ Table Design with Primary & Foreign Keys
- ✅ Data Insertion (Bulk & Single)
- ✅ Complex JOINs (Multi-table)
- ✅ Subqueries
- ✅ Aggregate Functions
- ✅ Group By & Having
- ✅ Stored Procedures (IN/OUT parameters)
- ✅ Transactions (COMMIT/ROLLBACK)
- ✅ Index Management

---

*Generated from: Mini project.sql*