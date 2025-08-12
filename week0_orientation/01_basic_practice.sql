-- ========================================================================================================================================
-- SQL Orientation : SQL Fundamentals 
--NOTES:
--DATEDIFF(interval, date1,date2) -- NOT INCLUDED IN PSGSQL
--CURDATE();
-- ========================================================================================================================================

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY, 
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (first_name, last_name, department, salary, hire_date)VALUES
('John', 'Smith', 'Sales', 50000.00, '2023-01-15'),
 ('Sarah', 'Johnson', 'Marketing', 55000.00, '2023-02-01'),
 ('Mike', 'Brown', 'IT', 65000.00, '2023-01-20'),
 ('Lisa', 'Davis', 'Sales', 52000.00, '2023-03-01'),
 ('Tom', 'Wilson', 'IT', 70000.00, '2022-12-15'),
 ('Emma', 'Taylor', 'Marketing', 58000.00, '2023-02-15');


--select all 
SELECT * FROM employees;

--select specific
SELECT first_name, last_name, salary FROM employees;

--filter by department
SELECT * FROM employees WHERE department = 'Sales';

--sort by salary (high to low)
SELECT* FROM employees ORDER BY salary DESC; 

--count employees by depart
SELECT department, COUNT(*) as employee_count 
FROM employees
GROUP BY department;

--avg salary by depart 
SELECT department, AVG(salary) as avg_salary
FROM employees 
GROUP BY department;

--employees hired in 2023 
SELECT * FROM employees
WHERE hire_date >= '2023-01-01';

--high earners (salary > 60000)
SELECT first_name, last_name, salary 
FROM employees
WHERE salary > 60000;

--find highest paid employee
SELECT * FROM employees
ORDER BY salary DESC 
LIMIT 1;

--find employees hired in last 6 months using date functions
-- Add some employees hired recently
INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('Alex', 'Martinez', 'IT', 75000.00, '2025-03-15'),      -- 4 months ago
('Jessica', 'Chen', 'Sales', 48000.00, '2025-01-10'),    -- 6+ months ago  
('Ryan', 'Kim', 'Marketing', 52000.00, '2025-06-01');    -- 2 months ago

SELECT first_name, last_name, hire_date, department
FROM employees
WHERE hire_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY hire_date DESC;


--calculate total payroll by department using SUM() and GROUP BY

SELECT department, SUM(salary) AS total_payroll
FROM employees
GROUP BY department;


--Find employees whose names start with 'S' using LIKE operator
SELECT first_name, last_name
FROM employees 
WHERE first_name LIKE 'S%';