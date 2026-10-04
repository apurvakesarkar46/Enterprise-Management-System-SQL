create database Enterprise_Management_System;
use Enterprise_Management_System;

select database();
show tables;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

select * from departments;

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

select * from departments;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2) NOT NULL,
    joining_date DATE NOT NULL,
    city VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

select * from employees;

INSERT INTO employees 
(employee_id, employee_name, department_id, salary, joining_date, city) 
VALUES
(101, 'Amit', 1, 85000.00, '2026-03-15', 'Delhi'),
(102, 'Rahul', 1, 72000.00, '2025-06-10', 'Mumbai'),
(103, 'Priya', 2, 65000.00, '2026-01-20', 'Pune'),
(104, 'Neha', 3, 95000.00, '2024-11-05', 'Delhi'),
(105, 'Amit', 1, 88000.00, '2026-03-15', 'Mumbai'),
(106, 'Ravi', NULL, 50000.00, '2026-07-01', 'Pune'),
(107, 'Anita', 1, 92000.00, '2023-02-14', 'Bangalore'),
(108, 'Vijay', 2, 45000.00, '2026-05-18', 'Delhi'),
(109, 'Kiran', 3, 78000.00, '2025-09-20', 'Bangalore'),
(110, 'Pooja', 3, 62000.00, '2026-04-12', 'Mumbai');

select * from employees;

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    employee_id INT,
    project_cost DECIMAL(12, 2) NOT NULL,
    start_date DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

select * from projects;

INSERT INTO projects VALUES
(1, 'Website', 101, 400000.00, '2026-01-10'),
(2, 'Cloud', 101, 700000.00, '2026-02-15'),
(3, 'Security', 101, 150000.00, '2026-03-01'),
(4, 'Mobile App', 102, 300000.00, '2026-01-20'),
(5, 'Analytics', 103, 1200000.00, '2026-02-01'),
(6, 'Dashboard', 104, 50000.00, '2026-03-10');

select * from projects;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

select * from customers;

INSERT INTO customers 
(customer_id, customer_name, city) 
VALUES
(1, 'Amit', 'Delhi'),
(2, 'Rahul', 'Mumbai'),
(3, 'Priya', 'Pune'),
(4, 'Neha', 'Bangalore'),
(5, 'Ravi', 'Chennai');

select * from customers;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

select * from transactions;

INSERT INTO transactions VALUES
(1001, 1, '2026-01-10', 'CREDIT', 50000.00),
(1002, 1, '2026-01-15', 'DEBIT', 20000.00),
(1003, 1, '2026-02-10', 'CREDIT', 160000.00),
(1004, 2, '2026-01-12', 'CREDIT', 250000.00),
(1005, 3, '2026-01-20', 'CREDIT', 75000.00),
(1006, 3, '2026-02-05', 'CREDIT', 150000.00),
(1007, 4, '2026-03-01', 'CREDIT', 30000.00);


select * from transactions;

CREATE TABLE employee_history (
    employee_id INT,
    salary DECIMAL(10, 2) NOT NULL,
    effective_date DATE NOT NULL
);

select * from employee_history;

INSERT INTO employee_history 
(employee_id, salary, effective_date) 
VALUES
(101, 80000.00, '2025-03-15'),
(101, 85000.00, '2026-03-15'),
(102, 70000.00, '2024-06-10'),
(102, 72000.00, '2025-06-10'),
(103, 60000.00, '2025-01-20'),
(103, 65000.00, '2026-01-20');

select * from employee_history;

SELECT
    d.department_id,
    d.department_name,
    e.employee_id,
    e.employee_name,
    e.salary AS current_salary,
    e.joining_date,
    e.city,
    p.project_id,
    p.project_name,
    p.project_cost,
    p.start_date,
    h.salary AS historical_salary,
    h.effective_date
FROM departments d
JOIN employees e
    ON d.department_id = e.department_id
LEFT JOIN projects p
    ON e.employee_id = p.employee_id
LEFT JOIN employee_history h
    ON e.employee_id = h.employee_id;

    
-- queries 

SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS average_salary FROM employees GROUP BY department_id;

SELECT department_id, AVG(salary) AS average_salary FROM employees GROUP BY department_id HAVING (AVG(salary)>70000);

SELECT e.employee_name, d.department_name, e.salary
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.employee_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

SELECT employee_id
FROM projects
GROUP BY employee_id
HAVING COUNT(*) > 2;

SELECT employee_id,
       SUM(project_cost) AS total_cost
FROM projects
GROUP BY employee_id;

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;

SELECT MAX(salary)
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 5;

SELECT employee_name
FROM employees
GROUP BY employee_name
HAVING COUNT(*) > 1;

SELECT city
FROM employees
GROUP BY city
HAVING COUNT(*) > 10;

SELECT employee_id
FROM projects
GROUP BY employee_id
HAVING SUM(project_cost) > 1000000;

SELECT e.employee_id,
       e.employee_name,
       SUM(p.project_cost) AS total_cost
FROM employees e
JOIN projects p
ON e.employee_id = p.employee_id
GROUP BY e.employee_id, e.employee_name;

SELECT customer_id
FROM transactions
GROUP BY customer_id
HAVING SUM(amount) > 200000;

SELECT YEAR(transaction_date),
       MONTH(transaction_date),
       SUM(amount)
FROM transactions
GROUP BY YEAR(transaction_date),
         MONTH(transaction_date);

SELECT customer_id,
       SUM(amount)
FROM transactions
WHERE transaction_type = 'CREDIT'
GROUP BY customer_id;

SELECT customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(*) > 5;

SELECT c.customer_name, t.amount
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id;

SELECT c.customer_id
FROM customers c
LEFT JOIN transactions t
ON c.customer_id = t.customer_id
WHERE t.customer_id IS NULL;

SELECT department_id,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 1;

SELECT department_id,
       MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 40000;

SELECT *
FROM employees
WHERE joining_date >= '2026-01-01'
  AND joining_date < '2027-01-01';

SELECT *
FROM employees
ORDER BY joining_date DESC
LIMIT 1;

SELECT employee_id
FROM projects
GROUP BY employee_id
HAVING COUNT(DISTINCT project_id) >= 3;

SELECT e.employee_id
FROM employees e
LEFT JOIN projects p
ON e.employee_id = p.employee_id
WHERE p.project_id IS NULL;

SELECT *
FROM projects
ORDER BY project_cost DESC
LIMIT 1;

SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

SELECT department_id,
       MAX(salary) - MIN(salary) AS salary_range
FROM employees
GROUP BY department_id;

SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 5
   AND AVG(salary) > 60000;

SELECT employee_id,
       employee_name,
       department_id,
       salary,
       RANK() OVER (
           PARTITION BY department_id
           ORDER BY salary DESC
       ) AS salary_rank
FROM employees;

SELECT *
FROM (
    SELECT e.*,
           DENSE_RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees e
) x
WHERE salary_rank <= 3;

SELECT employee_id,
       salary,
       SUM(salary) OVER (
           ORDER BY employee_id
       ) AS running_total
FROM employees;

SELECT employee_id,
       salary,
       AVG(salary) OVER (
           PARTITION BY department_id
       ) AS department_avg
FROM employees;

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

SELECT *
FROM (
    SELECT h.*,
           ROW_NUMBER() OVER (
               PARTITION BY employee_id
               ORDER BY effective_date DESC
           ) AS rn
    FROM employee_history h
) x
WHERE rn = 1;

WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 80000
)
SELECT *
FROM high_salary;

SELECT department_id,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 1;

SELECT employee_id, joining_date
FROM employees
GROUP BY employee_id, joining_date
HAVING COUNT(*) > 1;

SELECT employee_id,
       employee_name,
       joining_date,
       ROW_NUMBER() OVER (
           PARTITION BY employee_id
           ORDER BY joining_date
       ) AS row_num
FROM employees;

SELECT customer_id,
       MAX(amount) AS highest_transaction
FROM transactions
GROUP BY customer_id;

SELECT *
FROM (
    SELECT t.*,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY amount DESC
           ) AS rn
    FROM transactions t
) x
WHERE rn = 1;

SELECT YEAR(transaction_date) AS yr,
       MONTH(transaction_date) AS mon,
       SUM(amount) AS total_amount
FROM transactions
GROUP BY YEAR(transaction_date),
         MONTH(transaction_date);

SELECT customer_id,
       YEAR(transaction_date) AS yr,
       MONTH(transaction_date) AS mon,
       SUM(amount) AS total_amount,
       RANK() OVER (
           PARTITION BY YEAR(transaction_date),
                        MONTH(transaction_date)
           ORDER BY SUM(amount) DESC
       ) AS customer_rank
FROM transactions
GROUP BY customer_id,
         YEAR(transaction_date),
         MONTH(transaction_date);

SELECT customer_id,
       transaction_date,
       amount,
       SUM(amount) OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date
       ) AS running_total
FROM transactions;

SELECT project_id,
       start_date,
       project_cost,
       SUM(project_cost) OVER (
           ORDER BY start_date
       ) AS cumulative_cost
FROM projects;

SELECT customer_id,
       transaction_date,
       amount,
       LAG(amount) OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date
       ) AS previous_amount
FROM transactions;

SELECT customer_id,
       transaction_date,
       amount,
       LEAD(amount) OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date
       ) AS next_amount
FROM transactions;

SELECT *
FROM transactions
WHERE amount IS NULL
   OR customer_id IS NULL
   OR amount < 0;

SELECT *
FROM (
    SELECT e.*,
           DENSE_RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS rnk
    FROM employees e
) x
WHERE rnk <= 2;
