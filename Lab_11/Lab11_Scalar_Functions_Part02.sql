-- ============================================================
-- DATABASE SYSTEMS
-- LAB 11 - NUMERIC AND DATE/TIME FUNCTIONS
-- ============================================================

USE scalar_lab;


-- ============================================================
-- TASK B1
-- Apply 15% discount to every product
-- ============================================================

SELECT
    ProdName,
    Price,
    ROUND(Price * 0.85, 2) AS DiscountedPrice
FROM Product;


-- ============================================================
-- TASK B2
-- Calculate 17% sales tax and final price
-- ============================================================

SELECT
    ProdName,
    ROUND(Price * 0.17, 2) AS Tax,
    ROUND(Price * 1.17, 2) AS PriceWithTax
FROM Product;


-- ============================================================
-- TASK B3
-- Floor and ceiling of price divided by 1000
-- ============================================================

SELECT
    ProdName,
    Price,
    FLOOR(Price / 1000) AS FloorVal,
    CEIL(Price / 1000) AS CeilVal
FROM Product;


-- ============================================================
-- TASK B4
-- Round product price to nearest hundred
-- ============================================================

SELECT
    ProdName,
    Price,
    ROUND(Price, -2) AS RoundedToHundred
FROM Product;


-- ============================================================
-- TASK B5
-- List products with odd product IDs
-- ============================================================

SELECT
    ProdID,
    ProdName
FROM Product
WHERE MOD(ProdID, 2) = 1;


-- ============================================================
-- TASK B6
-- Show year, month name and day of week of joining
-- ============================================================

SELECT
    CustName,
    JoinDate,
    YEAR(JoinDate) AS JoinYear,
    MONTHNAME(JoinDate) AS JoinMonth,
    DAYNAME(JoinDate) AS JoinDay
FROM Customer;


-- ============================================================
-- TASK B7
-- Format date of birth as DD-Month-YYYY
-- ============================================================

SELECT
    CustName,
    DOB,
    DATE_FORMAT(DOB, '%d-%M-%Y') AS FormattedDOB
FROM Customer;


-- ============================================================
-- TASK B8
-- Calculate current age in years
-- ============================================================

SELECT
    CustName,
    DOB,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM Customer;


-- ============================================================
-- TASK B9
-- Calculate number of days since joining
-- ============================================================

SELECT
    CustName,
    JoinDate,
    DATEDIFF(CURDATE(), JoinDate) AS DaysSinceJoin
FROM Customer;


-- ============================================================
-- TASK B10
-- Customers who joined in 2023
-- ============================================================

SELECT
    CustID,
    CustName,
    JoinDate
FROM Customer
WHERE YEAR(JoinDate) = 2023;


-- ============================================================
-- TASK B11
-- Products launched in Q4
-- ============================================================

SELECT
    ProdID,
    ProdName,
    LaunchDate
FROM Product
WHERE MONTH(LaunchDate) IN (10, 11, 12);


-- ============================================================
-- TASK B12
-- Customers who joined within the last 6 months
-- ============================================================

SELECT
    CustID,
    CustName,
    JoinDate
FROM Customer
WHERE JoinDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


-- ============================================================
-- TASK B13
-- Calculate product age in days
-- ============================================================

SELECT
    ProdName,
    LaunchDate,
    DATEDIFF(CURDATE(), LaunchDate) AS AgeInDays
FROM Product;


-- ============================================================
-- TASK B14
-- Calculate date exactly 90 days after launch
-- ============================================================

SELECT
    ProdName,
    LaunchDate,
    DATE_ADD(LaunchDate, INTERVAL 90 DAY) AS NinetyDaysLater
FROM Product;


-- ============================================================
-- TASK B15
-- Combined challenge
-- ============================================================

SELECT
    CONCAT(
        'Hello ',
        UPPER(TRIM(CustName)),
        ', age ',
        TIMESTAMPDIFF(YEAR, DOB, CURDATE()),
        ', joined ',
        DATE_FORMAT(JoinDate, '%b %Y')
    ) AS Summary
FROM Customer;
