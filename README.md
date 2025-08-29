# book-store-online-sale-
🚀 A Bookstore Management System using SQL to track books, customers, and orders. It supports stock calculation, sales tracking, revenue reports, and inventory management with queries for total, sold, and remaining stock. Helps manage book sales efficiently with clear insights.
📚 Bookstore Management System (SQL Project)

A simple yet powerful Bookstore Management System built with SQL to manage books, customers, and orders efficiently. This project demonstrates core database concepts like Joins, Grouping, Aggregation, and Aliasing, while also providing insights into stock management, sales tracking, and revenue analysis.

🚀 Features

Manage books, customers, and orders in structured tables

Track total stock, sold stock, and remaining stock for each book

Generate sales and revenue reports using SQL queries

Use aggregation functions (SUM, COUNT, AVG) for analysis

Apply Joins to connect multiple tables (Books, Orders, Customers)

Ensure clean, optimized queries with aliases and grouping

🛠️ Technologies Used

PostgreSQL / MySQL (any SQL RDBMS)

SQL Queries (DDL & DML)

📊 Sample Queries
-- Total revenue
select sum(total_amount) as revenue from orders;

-- Remaining stock after sales
select b.book_id, b.title, b.stock as total_stock,
       coalesce(sum(o.quantity),0) as sold_stock,
       b.stock - coalesce(sum(o.quantity),0) as remaining_stock
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id, b.title, b.stock;

🎯 Learning Outcomes

Strong understanding of relational databases

Hands-on practice with Joins, Group By, Aggregate Functions

Real-world use case of inventory and sales management

📌 Use Cases

Track and analyze book sales

Calculate remaining stock automatically

👨‍💻 Author

Developed by [Muhammad Daud] — Aspiring Data Analyst / SQL Developer.

📫 Contact Me

LinkedIn: [(https://www.linkedin.com/in/muhammad-daud-726b0a295/)]

Email: [mrdaudbajwa@gmail.com]



Generate monthly or yearly sales reports

👨‍💻 Author
