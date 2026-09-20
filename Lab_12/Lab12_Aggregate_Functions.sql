/* ============================================================
   DATABASE SYSTEMS - LAB #12
   TOPIC: AGGREGATE FUNCTIONS, GROUP BY AND HAVING

   ============================================================ */


/* ============================================================
   SECTION 1: RETAIL STORE DATABASE SETUP
   ============================================================ */

CREATE DATABASE IF NOT EXISTS agg_lab;
USE agg_lab;

DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;


/* -------------------------
   Customer Table
   ------------------------- */

CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(60) NOT NULL,
    City VARCHAR(30),
    JoinDate DATE
);


/* -------------------------
   Product Table
   ------------------------- */

CREATE TABLE Product (
    ProdID INT PRIMARY KEY,
    ProdName VARCHAR(60) NOT NULL,
    Category VARCHAR(30),
    Price DECIMAL(10,2),
    StockQty INT
);


/* -------------------------
   OrderItem Table
   ------------------------- */

CREATE TABLE OrderItem (
    OrderID INT PRIMARY KEY,
    CustID INT,
    ProdID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID),
    FOREIGN KEY (ProdID) REFERENCES Product(ProdID)
);


/* ============================================================
   INSERT CUSTOMER DATA
   ============================================================ */

INSERT INTO Customer VALUES
(1, 'Ali Khan', 'Lahore', '2022-01-15'),
(2, 'Sara Iqbal', 'Karachi', '2022-04-22'),
(3, 'Hamza Raza', 'Lahore', '2023-02-10'),
(4, 'Ayesha Noor', 'Islamabad', '2023-05-18'),
(5, 'Bilal Ahmed', 'Karachi', '2023-09-01'),
(6, 'Fatima Sheikh', NULL, '2024-01-12'),
(7, 'Usman Tariq', 'Lahore', '2024-06-30'),
(8, 'Maira Javed', 'Islamabad', '2024-08-25');


/* ============================================================
   INSERT PRODUCT DATA
   ============================================================ */

INSERT INTO Product VALUES
(101, 'Laptop Pro 15', 'Electronics', 185000.00, 12),
(102, 'Wireless Mouse', 'Electronics', 2500.00, 50),
(103, 'USB-C Cable', 'Electronics', 800.00, 100),
(104, 'Office Chair', 'Furniture', 18500.00, 8),
(105, 'Standing Desk', 'Furniture', 45000.50, 5),
(106, 'Notebook A4', 'Stationery', 350.00, 200),
(107, 'Ballpoint Pen 10pk', 'Stationery', 450.00, 150),
(108, 'Coffee Beans 1kg', 'Grocery', 1899.99, 30),
(109, 'Green Tea Box', 'Grocery', 650.00, 45),
(110, 'Bluetooth Speaker', 'Electronics', 7500.00, 18);


/* ============================================================
   INSERT ORDER DATA
   ============================================================ */

INSERT INTO OrderItem VALUES
(1001, 1, 101, 1, '2023-03-10'),
(1002, 1, 102, 2, '2023-03-10'),
(1003, 2, 104, 1, '2023-05-22'),
(1004, 2, 106, 5, '2023-05-22'),
(1005, 3, 101, 1, '2023-08-15'),
(1006, 3, 110, 1, '2023-08-15'),
(1007, 4, 108, 3, '2023-11-02'),
(1008, 5, 103, 4, '2024-01-20'),
(1009, 5, 102, 1, '2024-01-20'),
(1010, 6, 105, 1, '2024-02-14'),
(1011, 7, 107, 2, '2024-04-08'),
(1012, 7, 106, 10, '2024-04-08'),
(1013, 7, 109, 3, '2024-07-19'),
(1014, 2, 110, 1, '2024-09-05'),
(1015, 3, 108, 2, '2024-10-11');


/* ============================================================
   PART A - WHOLE-TABLE AGGREGATES
   ============================================================ */


/* -------------------------
   Task A1
   Count total customers, products and orders
   ------------------------- */

-- Task A1
SELECT
    (SELECT COUNT(*) FROM Customer) AS TotalCustomers,
    (SELECT COUNT(*) FROM Product) AS TotalProducts,
    (SELECT COUNT(*) FROM OrderItem) AS TotalOrders;


/* -------------------------
   Task A2
   Cheapest and most expensive products
   ------------------------- */

-- Task A2
SELECT
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM Product;


/* -------------------------
   Task A3
   Average price of all products
   ------------------------- */

-- Task A3
SELECT
    ROUND(AVG(Price), 2) AS AveragePrice
FROM Product;


/* -------------------------
   Task A4
   Total stock quantity
   ------------------------- */

-- Task A4
SELECT
    SUM(StockQty) AS TotalStockQuantity
FROM Product;


/* -------------------------
   Task A5
   Number of distinct cities
   ------------------------- */

-- Task A5
SELECT
    COUNT(DISTINCT City) AS DistinctCities
FROM Customer;


/* -------------------------
   Task A6
   Number of distinct product categories
   ------------------------- */

-- Task A6
SELECT
    COUNT(DISTINCT Category) AS DistinctCategories
FROM Product;


/* -------------------------
   Task A7
   Customers with and without recorded city
   ------------------------- */

-- Task A7 - Customers with recorded city
SELECT
    COUNT(City) AS CustomersWithCity
FROM Customer;

-- Task A7 - Customers without recorded city
SELECT
    COUNT(*) - COUNT(City) AS CustomersWithoutCity
FROM Customer;


/* -------------------------
   Task A8
   Earliest and latest order date
   ------------------------- */

-- Task A8
SELECT
    MIN(OrderDate) AS EarliestOrderDate,
    MAX(OrderDate) AS LatestOrderDate
FROM OrderItem;


/* -------------------------
   Task A9
   Total revenue
   ------------------------- */

-- Task A9
SELECT
    SUM(o.Quantity * p.Price) AS TotalRevenue
FROM OrderItem o
JOIN Product p
    ON o.ProdID = p.ProdID;


/* -------------------------
   Task A10
   Average quantity per order
   ------------------------- */

-- Task A10
SELECT
    ROUND(AVG(Quantity), 2) AS AverageQuantityPerOrder
FROM OrderItem;


/* ============================================================
   PART B - GROUP BY, HAVING AND JOINS
   ============================================================ */


/* -------------------------
   Task B1
   Number of customers in each city
   ------------------------- */

-- Task B1
SELECT
    City,
    COUNT(*) AS NumCustomers
FROM Customer
GROUP BY City
ORDER BY NumCustomers DESC;


/* -------------------------
   Task B2
   Number of products in each category
   ------------------------- */

-- Task B2
SELECT
    Category,
    COUNT(*) AS NumProducts
FROM Product
GROUP BY Category
ORDER BY NumProducts DESC;


/* -------------------------
   Task B3
   Average, minimum and maximum price per category
   ------------------------- */

-- Task B3
SELECT
    Category,
    ROUND(AVG(Price), 2) AS AveragePrice,
    MIN(Price) AS MinimumPrice,
    MAX(Price) AS MaximumPrice
FROM Product
GROUP BY Category
ORDER BY AveragePrice DESC;


/* -------------------------
   Task B4
   Total stock quantity per category
   ------------------------- */

-- Task B4
SELECT
    Category,
    SUM(StockQty) AS TotalStock
FROM Product
GROUP BY Category
ORDER BY TotalStock DESC;


/* -------------------------
   Task B5
   Number of orders placed in each year
   ------------------------- */

-- Task B5
SELECT
    YEAR(OrderDate) AS OrderYear,
    COUNT(*) AS NumOrders
FROM OrderItem
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;


/* -------------------------
   Task B6
   Number of orders placed each month of 2024
   ------------------------- */

-- Task B6
SELECT
    MONTH(OrderDate) AS Month,
    COUNT(*) AS NumOrders
FROM OrderItem
WHERE YEAR(OrderDate) = 2024
GROUP BY MONTH(OrderDate)
ORDER BY Month;


/* -------------------------
   Task B7
   Categories with average price greater than 5000
   ------------------------- */

-- Task B7
SELECT
    Category,
    ROUND(AVG(Price), 2) AS AveragePrice
FROM Product
GROUP BY Category
HAVING AVG(Price) > 5000;


/* -------------------------
   Task B8
   Cities with more than one customer
   ------------------------- */

-- Task B8
SELECT
    City,
    COUNT(*) AS NumCustomers
FROM Customer
WHERE City IS NOT NULL
GROUP BY City
HAVING COUNT(*) > 1
ORDER BY NumCustomers DESC;


/* -------------------------
   Task B9
   Number of orders per customer
   Including customers with zero orders
   ------------------------- */

-- Task B9
SELECT
    c.CustID,
    c.CustName,
    COUNT(o.OrderID) AS NumOrders
FROM Customer c
LEFT JOIN OrderItem o
    ON c.CustID = o.CustID
GROUP BY c.CustID, c.CustName
ORDER BY NumOrders DESC;


/* -------------------------
   Task B10
   Total quantity sold for each product
   Including products never sold
   ------------------------- */

-- Task B10
SELECT
    p.ProdID,
    p.ProdName,
    COALESCE(SUM(o.Quantity), 0) AS TotalQty
FROM Product p
LEFT JOIN OrderItem o
    ON p.ProdID = o.ProdID
GROUP BY p.ProdID, p.ProdName
ORDER BY TotalQty DESC;


/* -------------------------
   Task B11
   Total revenue per product category
   ------------------------- */

-- Task B11
SELECT
    p.Category,
    SUM(o.Quantity * p.Price) AS Revenue
FROM OrderItem o
JOIN Product p
    ON o.ProdID = p.ProdID
GROUP BY p.Category
ORDER BY Revenue DESC;


/* -------------------------
   Task B12
   Total spend per customer
   Including customers with no orders
   ------------------------- */

-- Task B12
SELECT
    c.CustName,
    COALESCE(SUM(o.Quantity * p.Price), 0) AS TotalSpend
FROM Customer c
LEFT JOIN OrderItem o
    ON c.CustID = o.CustID
LEFT JOIN Product p
    ON o.ProdID = p.ProdID
GROUP BY c.CustID, c.CustName
ORDER BY TotalSpend DESC;


/* -------------------------
   Task B13
   Customers whose total spend exceeds 50,000
   ------------------------- */

-- Task B13
SELECT
    c.CustName,
    SUM(o.Quantity * p.Price) AS TotalSpend
FROM Customer c
JOIN OrderItem o
    ON c.CustID = o.CustID
JOIN Product p
    ON o.ProdID = p.ProdID
GROUP BY c.CustID, c.CustName
HAVING SUM(o.Quantity * p.Price) > 50000
ORDER BY TotalSpend DESC;


/* -------------------------
   Task B14
   Customers and total revenue per city
   Only cities with more than one customer
   ------------------------- */

-- Task B14
SELECT
    c.City,
    COUNT(DISTINCT c.CustID) AS NumCustomers,
    COALESCE(SUM(o.Quantity * p.Price), 0) AS TotalRevenue
FROM Customer c
LEFT JOIN OrderItem o
    ON c.CustID = o.CustID
LEFT JOIN Product p
    ON o.ProdID = p.ProdID
WHERE c.City IS NOT NULL
GROUP BY c.City
HAVING COUNT(DISTINCT c.CustID) > 1
ORDER BY TotalRevenue DESC;


/* -------------------------
   Task B15
   Top 3 best-selling products
   ------------------------- */

-- Task B15
SELECT
    p.ProdName,
    SUM(o.Quantity) AS TotalQty
FROM Product p
JOIN OrderItem o
    ON p.ProdID = o.ProdID
GROUP BY p.ProdID, p.ProdName
ORDER BY TotalQty DESC
LIMIT 3;


/* -------------------------
   Task B16
   Total revenue for each year
   ------------------------- */

-- Task B16
SELECT
    YEAR(o.OrderDate) AS OrderYear,
    SUM(o.Quantity * p.Price) AS Revenue
FROM OrderItem o
JOIN Product p
    ON o.ProdID = p.ProdID
GROUP BY YEAR(o.OrderDate)
ORDER BY OrderYear;


/* -------------------------
   Task B17
   Average order value
   ------------------------- */

-- Task B17
SELECT
    ROUND(AVG(OrderTotal), 2) AS AverageOrderValue
FROM (
    SELECT
        o.OrderID,
        SUM(o.Quantity * p.Price) AS OrderTotal
    FROM OrderItem o
    JOIN Product p
        ON o.ProdID = p.ProdID
    GROUP BY o.OrderID
) AS OrderValues;


/* ============================================================
   SECTION 2: ASSESSMENT PROBLEM
   UNIVERSITY DATABASE
   ============================================================ */


/* ============================================================
   UNIVERSITY DATABASE SETUP
   ============================================================ */

CREATE DATABASE IF NOT EXISTS uni_lab;
USE uni_lab;

DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;


/* -------------------------
   Student Table
   ------------------------- */

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(60) NOT NULL,
    City VARCHAR(30),
    EnrollDate DATE
);


/* -------------------------
   Course Table
   ------------------------- */

CREATE TABLE Course (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(60) NOT NULL,
    Department VARCHAR(30),
    Credits INT,
    Fee DECIMAL(10,2)
);


/* -------------------------
   Enrollment Table
   ------------------------- */

CREATE TABLE Enrollment (
    EnrollID INT PRIMARY KEY,
    StudentID INT,
    CourseID VARCHAR(10),
    Marks INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


/* ============================================================
   INSERT STUDENT DATA
   ============================================================ */

INSERT INTO Student VALUES
(1001, 'Ahmad Raza', 'Lahore', '2022-09-01'),
(1002, 'Sara Imran', 'Karachi', '2022-09-01'),
(1003, 'Bilal Khan', 'Lahore', '2023-09-01'),
(1004, 'Fatima Ali', 'Islamabad', '2022-09-01'),
(1005, 'Hira Yousaf', NULL, '2024-09-01'),
(1006, 'Zain Abbas', 'Karachi', '2023-09-01'),
(1007, 'Mehwish Anwar', 'Lahore', '2022-09-01'),
(1008, 'Talha Hussain', 'Islamabad', '2024-09-01'),
(1009, 'Areeba Yasin', 'Lahore', '2023-09-01');


/* ============================================================
   INSERT COURSE DATA
   ============================================================ */

INSERT INTO Course VALUES
('CS101', 'Intro to Programming', 'Computer Science', 3, 25000),
('CS201', 'Database Systems', 'Computer Science', 3, 28000),
('CS301', 'Operating Systems', 'Computer Science', 4, 30000),
('MT101', 'Calculus I', 'Mathematics', 3, 22000),
('EE201', 'Digital Logic', 'Electrical Engg', 3, 26000),
('BB301', 'Marketing Basics', 'Business', 3, 24000);


/* ============================================================
   INSERT ENROLLMENT DATA
   ============================================================ */

INSERT INTO Enrollment VALUES
(1, 1001, 'CS101', 78, '2022-09-15'),
(2, 1001, 'CS201', 85, '2023-09-15'),
(3, 1001, 'MT101', 90, '2022-09-15'),
(4, 1002, 'CS101', 65, '2022-09-15'),
(5, 1002, 'CS201', 72, '2023-09-15'),
(6, 1003, 'CS101', 88, '2023-09-15'),
(7, 1003, 'EE201', 80, '2023-09-15'),
(8, 1004, 'MT101', 95, '2022-09-15'),
(9, 1004, 'CS201', 70, '2023-09-15'),
(10, 1005, 'CS101', 55, '2024-09-15'),
(11, 1006, 'CS101', 82, '2023-09-15'),
(12, 1006, 'CS301', 76, '2024-09-15'),
(13, 1007, 'CS201', 91, '2023-09-15'),
(14, 1007, 'CS301', 86, '2024-09-15'),
(15, 1008, 'CS101', 60, '2024-09-15'),
(16, 1008, 'MT101', 68, '2024-09-15');


/* ============================================================
   ASSESSMENT QUESTIONS
   ============================================================ */


/* -------------------------
   Q1
   Number of students and courses
   ------------------------- */

-- Q1
SELECT
    (SELECT COUNT(*) FROM Student) AS TotalStudents,
    (SELECT COUNT(*) FROM Course) AS TotalCourses;


/* -------------------------
   Q2
   Distinct student cities
   ------------------------- */

-- Q2
SELECT
    COUNT(DISTINCT City) AS DistinctCities
FROM Student;


/* -------------------------
   Q3
   Average, minimum and maximum marks
   ------------------------- */

-- Q3
SELECT
    ROUND(AVG(Marks), 2) AS AverageMarks,
    MIN(Marks) AS MinimumMarks,
    MAX(Marks) AS MaximumMarks
FROM Enrollment;


/* -------------------------
   Q4
   Number of students in each city
   Include NULL city at the end
   ------------------------- */

-- Q4
SELECT
    City,
    COUNT(*) AS NumStudents
FROM Student
GROUP BY City
ORDER BY
    CASE WHEN City IS NULL THEN 1 ELSE 0 END,
    NumStudents DESC;


/* -------------------------
   Q5
   Number of courses by department
   ------------------------- */

-- Q5
SELECT
    Department,
    COUNT(*) AS NumCourses
FROM Course
GROUP BY Department
ORDER BY NumCourses DESC;


/* -------------------------
   Q6
   Course name, enrolled students and average marks
   ------------------------- */

-- Q6
SELECT
    c.CourseName,
    COUNT(e.EnrollID) AS NumStudents,
    ROUND(AVG(e.Marks), 2) AS AverageMarks
FROM Course c
LEFT JOIN Enrollment e
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY AverageMarks DESC;


/* -------------------------
   Q7
   Courses with average marks above 80
   ------------------------- */

-- Q7
SELECT
    c.CourseName,
    ROUND(AVG(e.Marks), 2) AS AvgMarks
FROM Course c
JOIN Enrollment e
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING AVG(e.Marks) > 80
ORDER BY AvgMarks DESC;


/* -------------------------
   Q8
   Total fee revenue per department
   ------------------------- */

-- Q8
SELECT
    c.Department,
    SUM(c.Fee) AS TotalRevenue
FROM Student s
JOIN Enrollment e
    ON s.StudentID = e.StudentID
JOIN Course c
    ON e.CourseID = c.CourseID
GROUP BY c.Department
ORDER BY TotalRevenue DESC;


/* -------------------------
   Q9
   Courses enrolled and average marks per student
   Include students with no enrollments
   ------------------------- */

-- Q9
SELECT
    s.FullName,
    COUNT(e.EnrollID) AS NumCourses,
    ROUND(AVG(e.Marks), 2) AS AverageMarks
FROM Student s
LEFT JOIN Enrollment e
    ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FullName
ORDER BY NumCourses DESC, AverageMarks DESC;


/* -------------------------
   Q10
   Students who scored above 85 in at least one course
   ------------------------- */

-- Q10
SELECT
    s.FullName,
    MAX(e.Marks) AS HighestMark
FROM Student s
JOIN Enrollment e
    ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FullName
HAVING MAX(e.Marks) > 85
ORDER BY HighestMark DESC;


/* -------------------------
   Q11
   Departments with average marks below 75
   ------------------------- */

-- Q11
SELECT
    c.Department,
    ROUND(AVG(e.Marks), 2) AS OverallAvgMarks
FROM Course c
JOIN Enrollment e
    ON c.CourseID = e.CourseID
GROUP BY c.Department
HAVING AVG(e.Marks) < 75
ORDER BY OverallAvgMarks;


/* -------------------------
   Q12
   Top 3 students by total fee paid
   ------------------------- */

-- Q12
SELECT
    s.FullName,
    SUM(c.Fee) AS TotalFee
FROM Student s
JOIN Enrollment e
    ON s.StudentID = e.StudentID
JOIN Course c
    ON e.CourseID = c.CourseID
GROUP BY s.StudentID, s.FullName
ORDER BY TotalFee DESC
LIMIT 3;


/* ============================================================
   END OF LAB#12
   ============================================================ */
