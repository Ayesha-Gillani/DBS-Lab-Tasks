-- ============================================================
-- DATABASE SYSTEMS LAB 4
-- Topic: Database Normalization and First Normal Form (1NF)
-- Scenario: Online Bookstore
-- ============================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS Bookstore_Lab4;

USE Bookstore_Lab4;


-- ============================================================
-- TASK 1: FUNCTIONAL DEPENDENCIES AND ANOMALIES
-- ============================================================

/*
Functional Dependencies:

1. OrderID -> OrderDate, CustID
2. CustID -> CustName, CustEmail
3. BookID -> BookTitle, Publisher, UnitPrice
4. (OrderID, BookID) -> Qty

Candidate Key in the 1NF relation:
(OrderID, BookID)

Anomalies:

Insertion Anomaly:
A new customer or book cannot be stored properly without
creating an order record.

Update Anomaly:
If a customer's email changes, the email may need to be
updated in multiple order rows.

Deletion Anomaly:
If an order containing the only record of a particular book
is deleted, information about that book may also be lost.
*/


-- ============================================================
-- TASK 2: CONVERT THE RAW DATA INTO 1NF
-- ============================================================

/*
1NF Rules:
- Every cell must contain one atomic value.
- No repeating groups.
- Each row must be uniquely identifiable.

In the original data, one order can contain multiple books.
Therefore, each book is placed in a separate row.

Primary Key:
(OrderID, BookID)
*/


-- Remove old table if it already exists
DROP TABLE IF EXISTS OrderBook_1NF;


-- Create 1NF Table
CREATE TABLE OrderBook_1NF
(
    OrderID VARCHAR(10),
    OrderDate DATE,
    CustID VARCHAR(10),
    CustName VARCHAR(50),
    CustEmail VARCHAR(100),

    BookID VARCHAR(10),
    BookTitle VARCHAR(100),
    Publisher VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    Qty INT,

    PRIMARY KEY (OrderID, BookID)
);


-- ============================================================
-- INSERT DATA INTO 1NF TABLE
-- ============================================================

INSERT INTO OrderBook_1NF
(OrderID, OrderDate, CustID, CustName, CustEmail,
 BookID, BookTitle, Publisher, UnitPrice, Qty)
VALUES

-- Order O-501
('O-501', '2026-04-02', 'C-11', 'Bilal',
 'bilal@x.com', 'B-1', 'SQL Basics',
 'Pearson', 1200, 1),

('O-501', '2026-04-02', 'C-11', 'Bilal',
 'bilal@x.com', 'B-2', 'Python 101',
 'OReilly', 1500, 2),

-- Order O-502
('O-502', '2026-04-03', 'C-12', 'Areeba',
 'areeba@x.com', 'B-1', 'SQL Basics',
 'Pearson', 1200, 3),

-- Order O-503
('O-503', '2026-04-05', 'C-11', 'Bilal',
 'bilal@x.com', 'B-3', 'Networks',
 'Pearson', 1800, 1),

('O-503', '2026-04-05', 'C-11', 'Bilal',
 'bilal@x.com', 'B-2', 'Python 101',
 'OReilly', 1500, 1);


-- ============================================================
-- VIEW ALL 1NF DATA
-- ============================================================

SELECT * 
FROM OrderBook_1NF;


-- ============================================================
-- CHECK PRIMARY KEY
-- ============================================================

DESCRIBE OrderBook_1NF;


-- ============================================================
