# Electronics Project Summary

## Overview
This SQL project implements an **Electronics Store Management System** with a normalized database schema for managing customers, products, and orders.

---

## Database Schema

### Tables Present

| Table | Primary Key | Description |
|-------|-------------|-------------|
| `customers` | `customer_id` | Stores customer information (name, city) |
| `products` | `product_id` | Stores product inventory (name, price) |
| `orders` | `order_id` | Stores order details with customer, product, date, quantity, amount |

---

## Entity-Relationship (ER) Model

```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   CUSTOMERS    │       │     ORDERS      │       │    PRODUCTS    │
├─────────────────┤       ├─────────────────┤       ├─────────────────┤
│ customer_id (PK)│◄──────│ customer_id (FK)│       │ product_id (PK)│
│ name            │       │ order_id (PK)   │──────►│ product_name   │
│ city            │       │ product_id (FK) │       │ price          │
└─────────────────┘       │ order_date      │       └─────────────────┘
       │                  │ quantity        │
       │                  │ amount          │
       │                  └─────────────────┘
       │                         │
       └─────────────────────────┘
```

### Relationship Details

| Table 1 | Relationship | Table 2 | Description |
|---------|--------------|---------|-------------|
| `customers` | 1:N | `orders` | One customer can place many orders |
| `products` | 1:N | `orders` | One product can be ordered many times |

### Key Constraints

- **Primary Keys**: `customer_id`, `product_id`, `order_id`
- **Foreign Keys**: 
  - `orders.customer_id` → `customers.customer_id`
  - `orders.product_id` → `products.product_id`

---

## Queries Used - Category Breakdown

### 1. Aggregate Queries
| Query | Function |
|-------|----------|
| Total Revenue | `SELECT SUM(amount)` |
| Top Customers | `SUM(amount)` with `ORDER BY` & `LIMIT` |
| Monthly Trends | `MONTH()`, `SUM(amount)` |
| Best Selling Product | `COUNT(*)` with `GROUP BY` |

### 2. JOIN Queries
- **INNER JOIN** - Customer purchase history (3-table join)
- **INNER JOIN** - Top customers by spending
- **INNER JOIN** - Revenue per city

### 3. GROUP BY Queries
- Total revenue per customer
- Revenue per city
- Product-wise sales (quantity)
- Orders per month
- Monthly revenue trends

### 4. HAVING Clause
- Customers with high spending (> ₹50,000)

### 5. Index Operations
```sql
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_customer_date ON orders(customer_id, order_date);
```

### 6. Stored Procedures
| Procedure | Purpose | Parameters |
|-----------|---------|------------|
| `GetCustomerOrders` | Get all orders for a customer | IN: `cust_id` |
| `MonthlyRevenue` | Calculate monthly revenue | None |
| `AddOrder` | Insert a new order | IN: `oid, cid, pid, odate, qty, amt` |

### 7. Transactions
```sql
START TRANSACTION;
INSERT INTO orders VALUES (...);
COMMIT;
```

---

## Data Summary

### Customers: **10** records
| ID | Name | City |
|----|------|------|
| 1 | Ravi | Hyderabad |
| 2 | Anita | Bangalore |
| 3 | Kiran | Chennai |
| 4 | Sneha | Mumbai |
| 5 | Mani | Kurnool |
| 6 | Arul | Tirupati |
| 7 | Heamanth | Venkatagiri |
| 8 | Monish | Kerala |
| 9 | Habi | Odisha |
| 10 | Arjun | Delhi |

### Products: **10** records
| ID | Product | Price (₹) |
|----|---------|-----------|
| 101 | Laptop | 60,000 |
| 102 | Mobile | 20,000 |
| 103 | Headphones | 2,000 |
| 104 | Keyboard | 1,500 |
| 105 | Mouse | 800 |
| 106 | Tablet | 30,000 |
| 107 | Monitor | 12,000 |
| 108 | Printer | 15,000 |
| 109 | Speaker | 5,000 |
| 110 | Webcam | 2,500 |

### Orders: **23** records
- Date range: January - May 2024
- Total order value: ₹3,99,300

---

## Key Analytics Queries

1. **Total Revenue** - `SUM(amount)` from all orders
2. **Top 3 Customers** - Highest spenders with `LIMIT 3`
3. **Monthly Trends** - Revenue by month
4. **Best Selling Product** - Most frequently ordered
5. **Customer Purchase History** - Full order details
6. **Revenue per City** - Geographic analysis
7. **Product-wise Sales** - Quantity sold per product
8. **High Spenders** - Customers spending > ₹50,000

---

## Technologies Demonstrated

- ✅ Database & Table Creation
- ✅ Primary & Foreign Key Constraints
- ✅ Bulk Data Insertion
- ✅ JOIN Queries (Multi-table)
- ✅ Aggregate Functions (SUM, COUNT)
- ✅ GROUP BY & HAVING
- ✅ Date Functions (MONTH)
- ✅ ORDER BY & LIMIT
- ✅ Index Creation (Single & Composite)
- ✅ Stored Procedures (IN parameters)
- ✅ Transaction Management (COMMIT)

---

*Generated from: Mini project-2.sql*