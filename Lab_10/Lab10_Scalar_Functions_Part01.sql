-- ============================================================
-- DATABASE SYSTEMS
-- LAB 10 - STRING FUNCTIONS
-- ============================================================

CREATE DATABASE IF NOT EXISTS scalar_lab;
USE scalar_lab;

DROP TABLE IF EXISTS Product, Customer;

CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(60) NOT NULL,
    Email VARCHAR(80),
    City VARCHAR(30),
    Phone VARCHAR(20),
    JoinDate DATE,
    DOB DATE
);

CREATE TABLE Product (
    ProdID INT PRIMARY KEY,
    ProdName VARCHAR(60) NOT NULL,
    Category VARCHAR(30),
    Price DECIMAL(10,2),
    StockQty INT,
    LaunchDate DATE
);

INSERT INTO Customer VALUES
(1, ' Ali Khan ', 'ali.khan@MAIL.com',
'Lahore', '0300-1112233','2022-01-15','1995-04-12'),
(2, 'Sara Iqbal', 'sara@example.com', 'Karachi',
'0301-4445566','2022-04-22','1998-11-20'),
(3, 'HAMZA RAZA', 'hamza@example.com',
'Lahore', '0302-7778899','2023-02-10','1997-08-05'),
(4, 'Ayesha Noor', NULL, 'Islamabad',
'0303-1234567','2023-05-18','1999-02-14'),
(5, 'bilal ahmed', 'bilal@MAIL.COM', 'Karachi',
'0304-2345678','2023-09-01','2000-06-30'),
(6, 'Fatima Sheikh', 'fatima@example.com',
NULL, '0305-3456789','2024-01-12','1996-10-25'),
(7, 'Usman Tariq', 'usman@example.com',
'Lahore', NULL,'2024-06-30','2001-03-18'),
(8, 'Maira Javed', 'maira@example.com',
'Islamabad','0307-5678901','2024-08-25','1994-12-09');

INSERT INTO Product VALUES
(101,'Laptop Pro 15', 'Electronics', 185000.00, 12, '2023-03-10'),
(102,'Wireless Mouse', 'Electronics', 2500.00, 50, '2022-07-22'),
(103,'USB-C Cable', 'Electronics', 800.00, 100,'2021-11-05'),
(104,'Office Chair', 'Furniture', 18500.00, 8, '2023-01-15'),
(105,'Standing Desk', 'Furniture', 45000.50, 5, '2024-02-28'),
(106,'Notebook A4', 'Stationery', 350.00, 200,'2020-04-01'),
(107,'Ballpoint Pen 10pk','Stationery',450.00,150,'2020-04-01'),
(108,'Coffee Beans 1kg','Grocery',1899.99,30,'2023-09-20'),
(109,'Green Tea Box','Grocery',650.00,45,'2022-12-12'),
(110,'Bluetooth Speaker','Electronics',7500.00,18,'2024-05-18');


-- ============================================================
-- TASK A1
-- Remove leading and trailing spaces
-- ============================================================

SELECT
    CustID,
    CustName AS OriginalName,
    TRIM(CustName) AS CleanedName
FROM Customer;


-- ============================================================
-- TASK A2
-- Display names in uppercase and lowercase
-- ============================================================

SELECT
    CustID,
    UPPER(CustName) AS UpperName,
    LOWER(CustName) AS LowerName
FROM Customer;


-- ============================================================
-- TASK A3
-- Show trimmed name and number of characters
-- ============================================================

SELECT
    CustID,
    TRIM(CustName) AS CleanedName,
    CHAR_LENGTH(TRIM(CustName)) AS NameLength
FROM Customer;


-- ============================================================
-- TASK A4
-- Build greeting for every customer
-- ============================================================

SELECT
    CustID,
    CONCAT('Dear ', TRIM(CustName), ', welcome!') AS Greeting
FROM Customer;


-- ============================================================
-- TASK A5
-- Extract username from email
-- ============================================================

SELECT
    CustName,
    SUBSTRING(Email, 1, LOCATE('@', Email) - 1) AS Username
FROM Customer
WHERE Email IS NOT NULL;


-- ============================================================
-- TASK A6
-- Extract email domain
-- ============================================================

SELECT
    CustName,
    SUBSTRING(Email, LOCATE('@', Email) + 1) AS Domain
FROM Customer
WHERE Email IS NOT NULL;


-- ============================================================
-- TASK A7
-- Show first 3 characters of each customer's name
-- ============================================================

SELECT
    CustID,
    CustName,
    LEFT(TRIM(CustName), 3) AS FirstThreeCharacters
FROM Customer;


-- ============================================================
-- TASK A8
-- Mask phone numbers
-- ============================================================

SELECT
    CustName,
    Phone,
    CONCAT(LEFT(Phone, 4), 'XXX-XXXX') AS MaskedPhone
FROM Customer
WHERE Phone IS NOT NULL;


-- ============================================================
-- TASK A9
-- Replace spaces in product names with hyphens
-- ============================================================

SELECT
    ProdID,
    REPLACE(ProdName, ' ', '-') AS SlugName
FROM Product;


-- ============================================================
-- TASK A10
-- Pad product IDs with leading zeros
-- ============================================================

SELECT
    ProdID,
    LPAD(ProdID, 5, '0') AS PaddedID
FROM Product;


-- ============================================================
-- TASK A11
-- Find products containing "Pro"
-- ============================================================

SELECT
    ProdID,
    ProdName,
    LOCATE('Pro', ProdName) AS ProPosition
FROM Product
WHERE LOCATE('Pro', ProdName) > 0;


-- ============================================================
-- TASK A12
-- Display first name only
-- ============================================================

SELECT
    CustID,
    CustName,
    SUBSTRING(
        TRIM(CustName),
        1,
        LOCATE(' ', TRIM(CustName)) - 1
    ) AS FirstName
FROM Customer;-- ============================================================
-- DATABASE SYSTEMS
-- LAB 10 - STRING FUNCTIONS
-- ============================================================

CREATE DATABASE IF NOT EXISTS scalar_lab;
USE scalar_lab;

DROP TABLE IF EXISTS Product, Customer;

CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(60) NOT NULL,
    Email VARCHAR(80),
    City VARCHAR(30),
    Phone VARCHAR(20),
    JoinDate DATE,
    DOB DATE
);

CREATE TABLE Product (
    ProdID INT PRIMARY KEY,
    ProdName VARCHAR(60) NOT NULL,
    Category VARCHAR(30),
    Price DECIMAL(10,2),
    StockQty INT,
    LaunchDate DATE
);

INSERT INTO Customer VALUES
(1, ' Ali Khan ', 'ali.khan@MAIL.com',
'Lahore', '0300-1112233','2022-01-15','1995-04-12'),
(2, 'Sara Iqbal', 'sara@example.com', 'Karachi',
'0301-4445566','2022-04-22','1998-11-20'),
(3, 'HAMZA RAZA', 'hamza@example.com',
'Lahore', '0302-7778899','2023-02-10','1997-08-05'),
(4, 'Ayesha Noor', NULL, 'Islamabad',
'0303-1234567','2023-05-18','1999-02-14'),
(5, 'bilal ahmed', 'bilal@MAIL.COM', 'Karachi',
'0304-2345678','2023-09-01','2000-06-30'),
(6, 'Fatima Sheikh', 'fatima@example.com',
NULL, '0305-3456789','2024-01-12','1996-10-25'),
(7, 'Usman Tariq', 'usman@example.com',
'Lahore', NULL,'2024-06-30','2001-03-18'),
(8, 'Maira Javed', 'maira@example.com',
'Islamabad','0307-5678901','2024-08-25','1994-12-09');

INSERT INTO Product VALUES
(101,'Laptop Pro 15', 'Electronics', 185000.00, 12, '2023-03-10'),
(102,'Wireless Mouse', 'Electronics', 2500.00, 50, '2022-07-22'),
(103,'USB-C Cable', 'Electronics', 800.00, 100,'2021-11-05'),
(104,'Office Chair', 'Furniture', 18500.00, 8, '2023-01-15'),
(105,'Standing Desk', 'Furniture', 45000.50, 5, '2024-02-28'),
(106,'Notebook A4', 'Stationery', 350.00, 200,'2020-04-01'),
(107,'Ballpoint Pen 10pk','Stationery',450.00,150,'2020-04-01'),
(108,'Coffee Beans 1kg','Grocery',1899.99,30,'2023-09-20'),
(109,'Green Tea Box','Grocery',650.00,45,'2022-12-12'),
(110,'Bluetooth Speaker','Electronics',7500.00,18,'2024-05-18');


-- ============================================================
-- TASK A1
-- Remove leading and trailing spaces
-- ============================================================

SELECT
    CustID,
    CustName AS OriginalName,
    TRIM(CustName) AS CleanedName
FROM Customer;


-- ============================================================
-- TASK A2
-- Display names in uppercase and lowercase
-- ============================================================

SELECT
    CustID,
    UPPER(CustName) AS UpperName,
    LOWER(CustName) AS LowerName
FROM Customer;


-- ============================================================
-- TASK A3
-- Show trimmed name and number of characters
-- ============================================================

SELECT
    CustID,
    TRIM(CustName) AS CleanedName,
    CHAR_LENGTH(TRIM(CustName)) AS NameLength
FROM Customer;


-- ============================================================
-- TASK A4
-- Build greeting for every customer
-- ============================================================

SELECT
    CustID,
    CONCAT('Dear ', TRIM(CustName), ', welcome!') AS Greeting
FROM Customer;


-- ============================================================
-- TASK A5
-- Extract username from email
-- ============================================================

SELECT
    CustName,
    SUBSTRING(Email, 1, LOCATE('@', Email) - 1) AS Username
FROM Customer
WHERE Email IS NOT NULL;


-- ============================================================
-- TASK A6
-- Extract email domain
-- ============================================================

SELECT
    CustName,
    SUBSTRING(Email, LOCATE('@', Email) + 1) AS Domain
FROM Customer
WHERE Email IS NOT NULL;


-- ============================================================
-- TASK A7
-- Show first 3 characters of each customer's name
-- ============================================================

SELECT
    CustID,
    CustName,
    LEFT(TRIM(CustName), 3) AS FirstThreeCharacters
FROM Customer;


-- ============================================================
-- TASK A8
-- Mask phone numbers
-- ============================================================

SELECT
    CustName,
    Phone,
    CONCAT(LEFT(Phone, 4), 'XXX-XXXX') AS MaskedPhone
FROM Customer
WHERE Phone IS NOT NULL;


-- ============================================================
-- TASK A9
-- Replace spaces in product names with hyphens
-- ============================================================

SELECT
    ProdID,
    REPLACE(ProdName, ' ', '-') AS SlugName
FROM Product;


-- ============================================================
-- TASK A10
-- Pad product IDs with leading zeros
-- ============================================================

SELECT
    ProdID,
    LPAD(ProdID, 5, '0') AS PaddedID
FROM Product;


-- ============================================================
-- TASK A11
-- Find products containing "Pro"
-- ============================================================

SELECT
    ProdID,
    ProdName,
    LOCATE('Pro', ProdName) AS ProPosition
FROM Product
WHERE LOCATE('Pro', ProdName) > 0;


-- ============================================================
-- TASK A12
-- Display first name only
-- ============================================================

SELECT
    CustID,
    CustName,
    SUBSTRING(
        TRIM(CustName),
        1,
        LOCATE(' ', TRIM(CustName)) - 1
    ) AS FirstName
FROM Customer;
