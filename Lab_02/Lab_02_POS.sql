-- ============================================================
-- DATABASE SYSTEMS - LAB 02
-- POINT OF SALE (POS) DATABASE
-- ============================================================

-- ============================================================
-- 1. CREATE DATABASE
-- ============================================================

CREATE DATABASE Point_of_Sale;

USE Point_of_Sale;


-- ============================================================
-- 2. CREATE ROLES
-- ============================================================

CREATE ROLE 'Admin';
CREATE ROLE 'User/Customer';
CREATE ROLE 'Salesman';


-- ============================================================
-- 3. CREATE CATEGORIES TABLE
-- ============================================================

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);


-- ============================================================
-- 4. CREATE DISCOUNTS/OFFERS TABLE
-- ============================================================

CREATE TABLE Discounts_Offers (
    discount_id INT PRIMARY KEY,
    discount_name VARCHAR(100) NOT NULL,
    discount_percentage DECIMAL(5,2),
    start_date DATE,
    end_date DATE
);


-- ============================================================
-- 5. CREATE PRODUCTS TABLE
-- ============================================================

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    discount_id INT,

    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id),

    FOREIGN KEY (discount_id)
        REFERENCES Discounts_Offers(discount_id)
);


-- ============================================================
-- 6. CREATE ORDERS TABLE
-- ============================================================

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    salesman_name VARCHAR(100),
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2)
);


-- ============================================================
-- 7. CREATE ORDER_ITEMS TABLE
-- ============================================================

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);


-- ============================================================
-- 8. INSERT 10 RECORDS INTO CATEGORIES
-- ============================================================

INSERT INTO Categories
(category_id, category_name, description)
VALUES
(1, 'Electronics', 'Electronic devices'),
(2, 'Mobile Phones', 'Smartphones and mobile phones'),
(3, 'Laptops', 'Laptop computers'),
(4, 'Accessories', 'Computer and mobile accessories'),
(5, 'Clothing', 'Clothes and garments'),
(6, 'Shoes', 'Footwear'),
(7, 'Home Appliances', 'Home electrical appliances'),
(8, 'Books', 'Books and study material'),
(9, 'Stationery', 'School and office stationery'),
(10, 'Grocery', 'Daily grocery products');


-- ============================================================
-- 9. INSERT 10 RECORDS INTO DISCOUNTS/OFFERS
-- ============================================================

INSERT INTO Discounts_Offers
(discount_id, discount_name, discount_percentage, start_date, end_date)
VALUES
(1, 'New Year Offer', 10.00, '2026-01-01', '2026-01-15'),
(2, 'Student Discount', 15.00, '2026-01-10', '2026-12-31'),
(3, 'Summer Sale', 20.00, '2026-06-01', '2026-06-30'),
(4, 'Eid Offer', 25.00, '2026-03-01', '2026-03-31'),
(5, 'Weekend Sale', 5.00, '2026-04-01', '2026-04-30'),
(6, 'Mega Sale', 30.00, '2026-05-01', '2026-05-31'),
(7, 'Back to School', 12.00, '2026-08-01', '2026-08-31'),
(8, 'Winter Sale', 18.00, '2026-11-01', '2026-11-30'),
(9, 'Special Offer', 8.00, '2026-09-01', '2026-09-30'),
(10, 'Clearance Sale', 35.00, '2026-12-01', '2026-12-31');


-- ============================================================
-- 10. INSERT 10 RECORDS INTO PRODUCTS
-- ============================================================

INSERT INTO Products
(product_id, product_name, price, stock_quantity, category_id, discount_id)
VALUES
(101, 'Samsung Galaxy A15', 55000.00, 20, 2, 2),
(102, 'iPhone 13', 150000.00, 15, 2, 3),
(103, 'Dell Laptop', 145000.00, 10, 3, 6),
(104, 'HP Laptop', 135000.00, 12, 3, 7),
(105, 'Wireless Mouse', 2500.00, 50, 4, 5),
(106, 'Keyboard', 3500.00, 40, 4, 1),
(107, 'Men Shirt', 4500.00, 30, 5, 4),
(108, 'Running Shoes', 7500.00, 25, 6, 8),
(109, 'Programming Book', 3000.00, 35, 8, 9),
(110, 'Notebook', 500.00, 100, 9, 10);


-- ============================================================
-- 11. INSERT 10 RECORDS INTO ORDERS
-- ============================================================

INSERT INTO Orders
(order_id, customer_name, salesman_name, order_date, total_amount)
VALUES
(1001, 'Ali', 'Ahmed', '2026-09-01', 55000.00),
(1002, 'Sara', 'Bilal', '2026-09-02', 150000.00),
(1003, 'Hassan', 'Ahmed', '2026-09-03', 145000.00),
(1004, 'Ayesha', 'Usman', '2026-09-04', 2500.00),
(1005, 'Fatima', 'Bilal', '2026-09-05', 7500.00),
(1006, 'Hamza', 'Ahmed', '2026-09-06', 4500.00),
(1007, 'Zainab', 'Usman', '2026-09-07', 3000.00),
(1008, 'Usman', 'Bilal', '2026-09-08', 3500.00),
(1009, 'Maryam', 'Ahmed', '2026-09-09', 135000.00),
(1010, 'Omar', 'Usman', '2026-09-10', 500.00);


-- ============================================================
-- 12. INSERT 10 RECORDS INTO ORDER_ITEMS
-- ============================================================

INSERT INTO Order_Items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 1, 55000.00),
(2, 1002, 102, 1, 150000.00),
(3, 1003, 103, 1, 145000.00),
(4, 1004, 105, 1, 2500.00),
(5, 1005, 108, 1, 7500.00),
(6, 1006, 107, 1, 4500.00),
(7, 1007, 109, 1, 3000.00),
(8, 1008, 106, 1, 3500.00),
(9, 1009, 104, 1, 135000.00),
(10, 1010, 110, 1, 500.00);


-- ============================================================
-- 13. DISPLAY ALL TABLES
-- ============================================================

SELECT * FROM Categories;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT * FROM Order_Items;

SELECT * FROM Discounts_Offers;


-- ============================================================
-- 14. SIMPLE REPORT:
-- PRODUCTS WITH THEIR CATEGORIES
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity
FROM Products p
INNER JOIN Categories c
ON p.category_id = c.category_id;


-- ============================================================
-- 15. SIMPLE REPORT:
-- PRODUCTS WITH DISCOUNTS
-- ============================================================

SELECT
    p.product_name,
    p.price,
    d.discount_name,
    d.discount_percentage
FROM Products p
INNER JOIN Discounts_Offers d
ON p.discount_id = d.discount_id;


-- ============================================================
-- 16. SIMPLE REPORT:
-- ORDER DETAILS
-- ============================================================

SELECT
    o.order_id,
    o.customer_name,
    o.salesman_name,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM Orders o
INNER JOIN Order_Items oi
ON o.order_id = oi.order_id
INNER JOIN Products p
ON oi.product_id = p.product_id;


-- ============================================================
-- 17. REPORT:
-- TOTAL SALES
-- ============================================================

SELECT
    SUM(total_amount) AS total_sales
FROM Orders;


-- ============================================================
-- 18. REPORT:
-- AVERAGE ORDER VALUE
-- ============================================================

SELECT
    AVG(total_amount) AS average_order_value
FROM Orders;


-- ============================================================
-- 19. REPORT:
-- HIGHEST ORDER
-- ============================================================

SELECT
    MAX(total_amount) AS highest_order
FROM Orders;


-- ============================================================
-- 20. REPORT:
-- LOWEST ORDER
-- ============================================================

SELECT
    MIN(total_amount) AS lowest_order
FROM Orders;


-- ============================================================
-- 21. REPORT:
-- SALESMAN-WISE SALES
-- ============================================================

SELECT
    salesman_name,
    SUM(total_amount) AS total_sales
FROM Orders
GROUP BY salesman_name;


-- ============================================================
-- 22. REPORT:
-- PRODUCTS WITH LOW STOCK
-- ============================================================

SELECT
    product_id,
    product_name,
    stock_quantity
FROM Products
WHERE stock_quantity < 20;


-- ============================================================
-- 23. REPORT:
-- PRODUCTS ABOVE 50,000
-- ============================================================

SELECT
    product_name,
    price
FROM Products
WHERE price > 50000;


-- ============================================================
-- END OF LAB 02
-- ============================================================
