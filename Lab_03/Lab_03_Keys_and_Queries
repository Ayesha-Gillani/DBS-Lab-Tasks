-- ============================================================
-- MYSQL LAB WORK
-- Topic: Database Keys, Table Commands and CRUD Operations
-- ============================================================

-- ------------------------------------------------------------
-- 1. CREATE DATABASE
-- ------------------------------------------------------------

CREATE DATABASE University_Lab;
USE University_Lab;


-- ------------------------------------------------------------
-- 2. CREATE DEPARTMENTS TABLE
-- Primary Key + Unique Key
-- ------------------------------------------------------------

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) UNIQUE
);


-- ------------------------------------------------------------
-- 3. CREATE STUDENTS TABLE
-- Primary Key + Unique Key + Foreign Key
-- ------------------------------------------------------------

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


-- ------------------------------------------------------------
-- 4. CREATE COURSES TABLE
-- Primary Key + Foreign Key
-- ------------------------------------------------------------

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


-- ------------------------------------------------------------
-- 5. CREATE INSTRUCTORS TABLE
-- Primary Key + Unique Key + Foreign Key
-- ------------------------------------------------------------

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


-- ------------------------------------------------------------
-- 6. CREATE ENROLLMENTS TABLE
-- Composite Primary Key + Foreign Keys
-- ------------------------------------------------------------

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    semester VARCHAR(20),

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);


-- ------------------------------------------------------------
-- 7. INSERT DATA INTO DEPARTMENTS
-- ------------------------------------------------------------

INSERT INTO departments (dept_id, dept_name)
VALUES
(1, 'Computer Science'),
(2, 'Electrical Engineering'),
(3, 'Software Engineering'),
(4, 'Information Technology');


-- ------------------------------------------------------------
-- 8. INSERT DATA INTO STUDENTS
-- ------------------------------------------------------------

INSERT INTO students (name, email, age, dept_id)
VALUES
('Ali', 'ali@gmail.com', 20, 1),
('Sara', 'sara@gmail.com', 21, 1),
('Ahmed', 'ahmed@gmail.com', 22, 2),
('Ayesha', 'ayesha@gmail.com', 20, 3),
('Hamza', 'hamza@gmail.com', 23, 3),
('Fatima', 'fatima@gmail.com', 21, 4);


-- ------------------------------------------------------------
-- 9. INSERT DATA INTO COURSES
-- ------------------------------------------------------------

INSERT INTO courses (course_id, course_name, dept_id)
VALUES
(101, 'Database Systems', 1),
(102, 'Artificial Intelligence', 1),
(201, 'Digital Logic Design', 2),
(301, 'Software Engineering', 3),
(302, 'Object Oriented Programming', 3),
(401, 'Web Development', 4);


-- ------------------------------------------------------------
-- 10. INSERT DATA INTO INSTRUCTORS
-- ------------------------------------------------------------

INSERT INTO instructors (instructor_id, name, email, dept_id)
VALUES
(1, 'Dr. Ahmed', 'ahmed@university.edu', 1),
(2, 'Dr. Sara', 'sara@university.edu', 2),
(3, 'Dr. Hassan', 'hassan@university.edu', 3),
(4, 'Dr. Fatima', 'fatima@university.edu', 4);


-- ------------------------------------------------------------
-- 11. INSERT DATA INTO ENROLLMENTS
-- ------------------------------------------------------------

INSERT INTO enrollments (student_id, course_id, semester)
VALUES
(1, 101, 'Fall 2025'),
(1, 102, 'Fall 2025'),
(2, 101, 'Fall 2025'),
(3, 201, 'Fall 2025'),
(4, 301, 'Spring 2026'),
(4, 302, 'Spring 2026'),
(5, 301, 'Spring 2026'),
(6, 401, 'Spring 2026');


-- ============================================================
-- 12. SELECT OPERATIONS
-- ============================================================

-- Display all departments
SELECT * FROM departments;

-- Display all students
SELECT * FROM students;

-- Display all courses
SELECT * FROM courses;

-- Display all instructors
SELECT * FROM instructors;

-- Display all enrollments
SELECT * FROM enrollments;


-- ============================================================
-- 13. UPDATE OPERATION
-- Update a student's name
-- ============================================================

UPDATE students
SET name = 'Ali Khan'
WHERE student_id = 1;

-- Check updated record
SELECT * FROM students
WHERE student_id = 1;


-- ============================================================
-- 14. DELETE OPERATION
-- Delete a student record
-- ============================================================

-- Student 6 has enrollment, so first delete enrollment
DELETE FROM enrollments
WHERE student_id = 6;

-- Now delete student
DELETE FROM students
WHERE student_id = 6;

-- Check students
SELECT * FROM students;


-- ============================================================
-- 15. ALTER TABLE - ADD NEW COLUMN
-- ============================================================

ALTER TABLE students
ADD phone VARCHAR(20);


-- Check table
SELECT * FROM students;


-- ============================================================
-- 16. UPDATE THE NEW COLUMN
-- ============================================================

UPDATE students
SET phone = '03001234567'
WHERE student_id = 1;

UPDATE students
SET phone = '03111234567'
WHERE student_id = 2;


-- ============================================================
-- 17. ALTER TABLE - MODIFY COLUMN
-- ============================================================

ALTER TABLE students
MODIFY age INT NOT NULL;


-- ============================================================
-- 18. ALTER TABLE - RENAME COLUMN
-- ============================================================

ALTER TABLE students
CHANGE phone phone_number VARCHAR(20);


-- ============================================================
-- 19. ALTER TABLE - ADD UNIQUE CONSTRAINT
-- ============================================================

ALTER TABLE students
ADD CONSTRAINT unique_phone UNIQUE (phone_number);


-- ============================================================
-- 20. JOINS
-- Practice joins between Students and Courses
-- ============================================================

-- INNER JOIN
SELECT
    students.student_id,
    students.name AS student_name,
    courses.course_id,
    courses.course_name,
    enrollments.semester
FROM students
INNER JOIN enrollments
    ON students.student_id = enrollments.student_id
INNER JOIN courses
    ON enrollments.course_id = courses.course_id;


-- ------------------------------------------------------------
-- LEFT JOIN
-- ------------------------------------------------------------

SELECT
    students.student_id,
    students.name AS student_name,
    courses.course_name
FROM students
LEFT JOIN enrollments
    ON students.student_id = enrollments.student_id
LEFT JOIN courses
    ON enrollments.course_id = courses.course_id;


-- ============================================================
-- 21. DEPARTMENT AND STUDENT JOIN
-- ============================================================

SELECT
    students.student_id,
    students.name AS student_name,
    departments.dept_name
FROM students
INNER JOIN departments
    ON students.dept_id = departments.dept_id;


-- ============================================================
-- 22. STUDENT + DEPARTMENT + COURSE JOIN
-- ============================================================

SELECT
    students.name AS student_name,
    departments.dept_name AS department,
    courses.course_name AS course,
    enrollments.semester
FROM students
INNER JOIN departments
    ON students.dept_id = departments.dept_id
INNER JOIN enrollments
    ON students.student_id = enrollments.student_id
INNER JOIN courses
    ON enrollments.course_id = courses.course_id;


-- ============================================================
-- 23. CANDIDATE KEY
-- ============================================================

-- student_id and email can uniquely identify a student.
-- student_id is selected as the Primary Key.
-- email acts as an alternate/candidate key because it is UNIQUE.

SELECT
    student_id,
    name,
    email
FROM students;


-- ============================================================
-- 24. COMPOSITE KEY
-- ============================================================

-- The enrollments table uses:
-- student_id + course_id
-- as a Composite Primary Key.

SELECT
    student_id,
    course_id,
    semester
FROM enrollments;


-- ============================================================
-- 25. SHOW TABLE STRUCTURES
-- ============================================================

DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE instructors;
DESCRIBE enrollments;


-- ============================================================
-- 26. SHOW TABLES
-- ============================================================

SHOW TABLES;


-- ============================================================
-- 27. TRUNCATE EXAMPLE
-- ============================================================

-- WARNING:
-- TRUNCATE removes ALL records from a table.
-- It should be used carefully.

-- Example:
-- TRUNCATE TABLE instructors;


-- ============================================================
-- 28. DROP EXAMPLE
-- ============================================================

-- WARNING:
-- DROP TABLE permanently removes the table and its data.
-- Example:
-- DROP TABLE instructors;


-- ============================================================
