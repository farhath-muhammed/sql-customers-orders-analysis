# SQL Analysis: Customers, Products & Orders | MySQL

A MySQL project that models customers, products, and orders in a 3-table relational schema and answers business questions using SQL queries.

## Objective

Practice relational database design and use SQL to answer real business questions from order data.

## Database Design

A 3-table relational schema with primary and foreign keys:

- `customers`
- `products`
- `orders`

```
customers (1) ───< orders >─── (1) products
```

## SQL Concepts Covered

- **Joins:** INNER, LEFT, RIGHT, and self joins
- **Subqueries**
- **GROUP BY** with **HAVING**
- **Date functions**
- **Indexes** for faster lookups

## Business Questions Answered

- Who is the top-spending customer?
- Which products have never been ordered?
- Which customers have an above-average order value?

## Project Structure

```
├── schema.sql      # table creation with keys
├── data.sql        # sample data
├── queries.sql     # analysis queries
└── README.md
```

## Tools Used

- MySQL

## How to Run

1. Open MySQL Workbench (or any MySQL client).
2. Run `schema.sql` to create the tables.
3. Run `data.sql` to load the sample data.
4. Run the queries in `queries.sql`.

## Author

**Farhath Muhammed VM**
📧 farhath.codes@gmail.com
