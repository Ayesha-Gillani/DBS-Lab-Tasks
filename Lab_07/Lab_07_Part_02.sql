-- ============================================
-- DATABASE SYSTEMS
-- LAB 07 - SQL Filters
-- PART 02 - BETWEEN, IN, LIKE, NULL,
-- ORDER BY and LIMIT
-- ============================================

USE filters_lab;


-- ============================================
-- PART B - BETWEEN, IN, LIKE, IS NULL,
-- ORDER BY, LIMIT
-- ============================================

-- Task B1
-- List employees with salary between 75,000 and 100,000.
-- Sort by salary ascending.

SELECT EmpName, Salary
FROM Employee
WHERE Salary BETWEEN 75000 AND 100000
ORDER BY Salary ASC;


-- Task B2
-- List employees hired between January 2020
-- and December 2022.

SELECT EmpName, HireDate
FROM Employee
WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31';


-- Task B3
-- Show employees whose salary is not
-- between 80,000 and 100,000.

SELECT EmpName, Salary
FROM Employee
WHERE Salary NOT BETWEEN 80000 AND 100000;


-- Task B4
-- List employees whose city is Lahore or Islamabad.
-- Sort by city, then by salary descending.

SELECT EmpName, City, Salary
FROM Employee
WHERE City IN ('Lahore', 'Islamabad')
ORDER BY City ASC, Salary DESC;


-- Task B5
-- Find employees in any department except
-- Engineering, Sales, and HR.

SELECT EmpName, DeptName
FROM Employee
WHERE DeptName NOT IN ('Engineering', 'Sales', 'HR');


-- Task B6
-- Show all employees whose name starts
-- with the letter M.

SELECT EmpName
FROM Employee
WHERE EmpName LIKE 'M%';


-- Task B7
-- Find employees whose name contains
-- the letter 'a' anywhere.

SELECT EmpName
FROM Employee
WHERE EmpName LIKE '%a%';


-- Task B8
-- Find employees whose name ends with 'an'.

SELECT EmpName
FROM Employee
WHERE EmpName LIKE '%an';


-- Task B9
-- Show employees whose job title contains
-- the word 'Engineer' but who do not work
-- in the Engineering department.

SELECT EmpName, JobTitle, DeptName
FROM Employee
WHERE JobTitle LIKE '%Engineer%'
AND DeptName != 'Engineering';


-- Task B10
-- List the names of employees who do not
-- have a recorded city.

SELECT EmpName
FROM Employee
WHERE City IS NULL;


-- Task B11
-- List employees who have a recorded city,
-- sorted alphabetically by city.

SELECT EmpName, City
FROM Employee
WHERE City IS NOT NULL
ORDER BY City ASC;


-- Task B12
-- Display the 3 highest paid employees.
-- Show EmpName and Salary.

SELECT EmpName, Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 3;


-- Task B13
-- Display the 5 most recently hired employees.

SELECT EmpName, HireDate
FROM Employee
ORDER BY HireDate DESC
LIMIT 5;


-- Task B14
-- List the bottom 3 salaries in the company.
-- Lowest first.

SELECT EmpName, Salary
FROM Employee
ORDER BY Salary ASC
LIMIT 3;


-- Task B15
-- Show all employees, sorted by department ascending,
-- then by hire date ascending within each department.

SELECT EmpName, DeptName, HireDate
FROM Employee
ORDER BY DeptName ASC, HireDate ASC;
