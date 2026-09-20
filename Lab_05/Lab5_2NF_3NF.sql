-- ============================================================
-- DATABASE SYSTEMS LAB 5
-- Topic: Conversion from 1NF to 2NF and 3NF
-- Scenario: Online Bookstore
-- ============================================================


-- Create Database
CREATE DATABASE IF NOT EXISTS Bookstore_Lab5;

USE Bookstore_Lab5;


-- ============================================================
-- STEP 1: 1NF TABLE
-- ============================================================

/*
The 1NF relation has the following attributes:

OrderID
OrderDate
CustID
CustName
CustEmail
BookID
BookTitle
Publisher
UnitPrice
Qty

Primary Key:
(OrderID, BookID)
*/


DROP TABLE IF EXISTS OrderBook_1NF;


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


-- Insert the 1NF data

INSERT INTO OrderBook_1NF
(OrderID, OrderDate, CustID, CustName, CustEmail,
 BookID, BookTitle, Publisher, UnitPrice, Qty)
VALUES

('O-501', '2026-04-02', 'C-11', 'Bilal',
 'bilal@x.com', 'B-1', 'SQL Basics',
 'Pearson', 1200, 1),

('O-501', '2026-04-02', 'C-11', 'Bilal',
 'bilal@x.com', 'B-2', 'Python 101',
 'OReilly', 1500, 2),

('O-502', '2026-04-03', 'C-12', 'Areeba',
 'areeba@x.com', 'B-1', 'SQL Basics',
 'Pearson', 1200, 3),

('O-503', '2026-04-05', 'C-11', 'Bilal',
 'bilal@x.com', 'B-3', 'Networks',
 'Pearson', 1800, 1),

('O-503', '2026-04-05', 'C-11', 'Bilal',
 'bilal@x.com', 'B-2', 'Python 101',
 'OReilly', 1500, 1);


-- ============================================================
-- STEP 2: CONVERSION FROM 1NF TO 2NF
-- ============================================================

/*
Primary Key of 1NF:
(OrderID, BookID)

Partial Dependencies:

OrderID -> OrderDate, CustID, CustName, CustEmail

BookID -> BookTitle, Publisher, UnitPrice

(OrderID, BookID) -> Qty

The attributes OrderDate, CustID, CustName and CustEmail
depend only on OrderID.

The attributes BookTitle, Publisher and UnitPrice
depend only on BookID.

Therefore, these are partial dependencies.

To achieve 2NF, we separate the order information,
book information and order-item information.
*/


-- Remove old 2NF tables if they exist

DROP TABLE IF EXISTS OrderItem_2NF;
DROP TABLE IF EXISTS Orders_2NF;
DROP TABLE IF EXISTS Book_2NF;


-- ============================================================
-- TABLE 1: ORDERS
-- ============================================================

CREATE TABLE Orders_2NF
(
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE,
    CustID VARCHAR(10),
    CustName VARCHAR(50),
    CustEmail VARCHAR(100)
);


-- ============================================================
-- TABLE 2: BOOK
-- ============================================================

CREATE TABLE Book_2NF
(
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(100),
    Publisher VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);


-- ============================================================
-- TABLE 3: ORDER ITEM
-- ============================================================

CREATE TABLE OrderItem_2NF
(
    OrderID VARCHAR(10),
    BookID VARCHAR(10),
    Qty INT,

    PRIMARY KEY (OrderID, BookID),

    FOREIGN KEY (OrderID)
        REFERENCES Orders_2NF(OrderID),

    FOREIGN KEY (BookID)
        REFERENCES Book_2NF(BookID)
);


-- ============================================================
-- INSERT DATA INTO 2NF TABLES
-- ============================================================


-- Orders

INSERT INTO Orders_2NF
(OrderID, OrderDate, CustID, CustName, CustEmail)
VALUES
('O-501', '2026-04-02', 'C-11', 'Bilal', 'bilal@x.com'),
('O-502', '2026-04-03', 'C-12', 'Areeba', 'areeba@x.com'),
('O-503', '2026-04-05', 'C-11', 'Bilal', 'bilal@x.com');


-- Books

INSERT INTO Book_2NF
(BookID, BookTitle, Publisher, UnitPrice)
VALUES
('B-1', 'SQL Basics', 'Pearson', 1200),
('B-2', 'Python 101', 'OReilly', 1500),
('B-3', 'Networks', 'Pearson', 1800);


-- Order Items

INSERT INTO OrderItem_2NF
(OrderID, BookID, Qty)
VALUES
('O-501', 'B-1', 1),
('O-501', 'B-2', 2),
('O-502', 'B-1', 3),
('O-503', 'B-3', 1),
('O-503', 'B-2', 1);


-- ============================================================
-- CHECK 2NF TABLES
-- ============================================================

SELECT * FROM Orders_2NF;

SELECT * FROM Book_2NF;

SELECT * FROM OrderItem_2NF;


-- ============================================================
-- STEP 3: CONVERSION FROM 2NF TO 3NF
-- ============================================================

/*
The 2NF Book table still contains:

BookID -> Publisher

This means publisher information is associated with the
book through the Publisher attribute.

For a proper 3NF design, publisher information is separated
into its own table.

This removes the transitive dependency involving publisher
information.

3NF tables:

Publisher
Book
Orders
OrderItem
*/


-- Remove old Book table

DROP TABLE IF EXISTS Book_3NF;

-- Create Publisher table

DROP TABLE IF EXISTS Publisher_3NF;


CREATE TABLE Publisher_3NF
(
    PublisherID VARCHAR(10) PRIMARY KEY,
    PublisherName VARCHAR(50)
);


-- ============================================================
-- CREATE FINAL 3NF BOOK TABLE
-- ============================================================

CREATE TABLE Book_3NF
(
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(100),
    PublisherID VARCHAR(10),
    UnitPrice DECIMAL(10,2),

    FOREIGN KEY (PublisherID)
        REFERENCES Publisher_3NF(PublisherID)
);


-- ============================================================
-- INSERT PUBLISHERS
-- ============================================================

INSERT INTO Publisher_3NF
(PublisherID, PublisherName)
VALUES
('P-01', 'Pearson'),
('P-02', 'OReilly');


-- ============================================================
-- INSERT BOOKS
-- ============================================================

INSERT INTO Book_3NF
(BookID, BookTitle, PublisherID, UnitPrice)
VALUES
('B-1', 'SQL Basics', 'P-01', 1200),
('B-2', 'Python 101', 'P-02', 1500),
('B-3', 'Networks', 'P-01', 1800);


-- ============================================================
-- FINAL 3NF ORDER TABLE
-- ============================================================

DROP TABLE IF EXISTS OrderItem_3NF;
DROP TABLE IF EXISTS Orders_3NF;


CREATE TABLE Orders_3NF
(
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE,
    CustID VARCHAR(10),
    CustName VARCHAR(50),
    CustEmail VARCHAR(100)
);


-- ============================================================
-- FINAL 3NF ORDER ITEM TABLE
-- ============================================================

CREATE TABLE OrderItem_3NF
(
    OrderID VARCHAR(10),
    BookID VARCHAR(10),
    Qty INT,

    PRIMARY KEY (OrderID, BookID),

    FOREIGN KEY (OrderID)
        REFERENCES Orders_3NF(OrderID),

    FOREIGN KEY (BookID)
        REFERENCES Book_3NF(BookID)
);


-- ============================================================
-- INSERT ORDERS
-- ============================================================

INSERT INTO Orders_3NF
(OrderID, OrderDate, CustID, CustName, CustEmail)
VALUES
('O-501', '2026-04-02', 'C-11', 'Bilal', 'bilal@x.com'),
('O-502', '2026-04-03', 'C-12', 'Areeba', 'areeba@x.com'),
('O-503', '2026-04-05', 'C-11', 'Bilal', 'bilal@x.com');


-- ============================================================
-- INSERT ORDER ITEMS
-- ============================================================

INSERT INTO OrderItem_3NF
(OrderID, BookID, Qty)
VALUES
('O-501', 'B-1', 1),
('O-501', 'B-2', 2),
('O-502', 'B-1', 3),
('O-503', 'B-3', 1),
('O-503', 'B-2', 1);


-- ============================================================
-- TASK 5: VERIFICATION QUERY
-- Recreate the original bookstore report
-- ============================================================

SELECT
    o.OrderID,
    o.OrderDate,
    o.CustID,
    o.CustName,
    o.CustEmail,
    b.BookID,
    b.BookTitle,
    p.PublisherName,
    b.UnitPrice,
    oi.Qty
FROM Orders_3NF o
JOIN OrderItem_3NF oi
    ON o.OrderID = oi.OrderID
JOIN Book_3NF b
    ON oi.BookID = b.BookID
JOIN Publisher_3NF p
    ON b.PublisherID = p.PublisherID
ORDER BY o.OrderID, b.BookID;


-- ============================================================
-- TASK 5: CUSTOMER TOTAL SPEND
-- ============================================================

SELECT
    o.CustID,
    o.CustName,
    SUM(b.UnitPrice * oi.Qty) AS TotalSpend
FROM Orders_3NF o
JOIN OrderItem_3NF oi
    ON o.OrderID = oi.OrderID
JOIN Book_3NF b
    ON oi.BookID = b.BookID
GROUP BY
    o.CustID,
    o.CustName
ORDER BY
    o.CustID;


-- ============================================================
-- TASK 6: REFLECTION
-- ============================================================

/*
The final 3NF schema reduces data redundancy by storing
customer/order, book, publisher and order-item information
in separate tables.

The insertion anomaly is reduced because books and publishers
can be stored independently.

The update anomaly is reduced because a book's price or
publisher information is stored in one place.

The deletion anomaly is reduced because deleting an order
does not automatically remove the independent book or
publisher information.

Primary keys uniquely identify records, while foreign keys
maintain relationships between the tables.
*/


-- ============================================================
-- VERIFY ALL FINAL TABLES
-- ============================================================

SHOW TABLES;

DESCRIBE Orders_3NF;
DESCRIBE OrderItem_3NF;
DESCRIBE Book_3NF;
DESCRIBE Publisher_3NF;


-- ============================================================
-- END OF LAB 5
-- ============================================================
