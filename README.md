# 🏢 Enterprise Management System — SQL

A structured **MySQL database management project** designed to simulate an enterprise environment and demonstrate practical SQL skills including database design, relationships, joins, aggregations, subqueries, CTEs, and advanced window functions.

## 📌 Project Overview

The **Enterprise Management System** is a relational database project developed using **MySQL**.

The database manages different aspects of an organization, including:

* 🏢 Departments
* 👨‍💼 Employees
* 📋 Projects
* 👥 Customers
* 💳 Transactions
* 📈 Employee Salary History

The project also contains a collection of SQL queries for analyzing employee information, department performance, project costs, customer transactions, salary rankings, and historical salary data.

## 🎯 Objectives

The main objectives of this task are to:

* Design a structured relational database.
* Create tables with **Primary Keys** and **Foreign Keys**.
* Insert and manage organizational data.
* Retrieve information using SQL queries.
* Perform data aggregation and analysis.
* Apply different types of SQL joins.
* Use subqueries and Common Table Expressions (CTEs).
* Implement SQL window functions.
* Analyze employee salaries and project costs.
* Analyze customer transaction patterns.
* Practice real-world database querying and reporting.

## 🛠️ Technologies Used

| Technology          | Purpose                                    |
| ------------------- | ------------------------------------------ |
| **MySQL**           | Database Management System                 |
| **SQL**             | Data definition, manipulation and analysis |
| **MySQL Workbench** | Database development and query execution   |

## 🗂️ Database 

[Enterprise_Management_System](https://github.com/apurvakesarkar46/Enterprise-Management-System-SQL/commit/c6d8219ccf1e371454edb80a463f88b489467893)

### Main Tables

```text
Enterprise_Management_System
│
├── departments
│
├── employees
│
├── projects
│
├── customers
│
├── transactions
│
└── employee_history
```

## 🔗 Table Relationships

### Departments → Employees

Each employee can be associated with a department through:

```text
departments.department_id
        ↓
employees.department_id
```

### Employees → Projects

Projects are associated with employees through:

```text
employees.employee_id
        ↓
projects.employee_id
```

### Customers → Transactions

Customer transactions are connected through:

```text
customers.customer_id
        ↓
transactions.customer_id
```

The database uses foreign-key relationships to maintain referential integrity.

## 📊 Database Tables

### 1. Departments

Stores organizational department information.

| Column          | Data Type    | Description     |
| --------------- | ------------ | --------------- |
| department_id   | INT          | Primary key     |
| department_name | VARCHAR(100) | Department name |

Example departments include **Engineering, HR, Finance, and Marketing**.

### 2. Employees

Stores employee information such as salary, joining date, department, and city.

| Column        | Data Type     | Description       |
| ------------- | ------------- | ----------------- |
| employee_id   | INT           | Primary key       |
| employee_name | VARCHAR(100)  | Employee name     |
| department_id | INT           | Foreign key       |
| salary        | DECIMAL(10,2) | Employee salary   |
| joining_date  | DATE          | Joining date      |
| city          | VARCHAR(100)  | Employee location |

### 3. Projects

Stores projects assigned to employees.

| Column       | Data Type     | Description        |
| ------------ | ------------- | ------------------ |
| project_id   | INT           | Primary key        |
| project_name | VARCHAR(100)  | Project name       |
| employee_id  | INT           | Foreign key        |
| project_cost | DECIMAL(12,2) | Project cost       |
| start_date   | DATE          | Project start date |


### 4. Customers

Stores customer information.

| Column        | Data Type    | Description       |
| ------------- | ------------ | ----------------- |
| customer_id   | INT          | Primary key       |
| customer_name | VARCHAR(100) | Customer name     |
| city          | VARCHAR(100) | Customer location |

### 5. Transactions

Stores customer financial transaction information.

| Column           | Data Type     | Description        |
| ---------------- | ------------- | ------------------ |
| transaction_id   | INT           | Primary key        |
| customer_id      | INT           | Foreign key        |
| transaction_date | DATE          | Transaction date   |
| transaction_type | VARCHAR(50)   | Credit/Debit       |
| amount           | DECIMAL(12,2) | Transaction amount |

### 6. Employee History

Stores historical salary information for employees.

| Column         | Data Type     | Description           |
| -------------- | ------------- | --------------------- |
| employee_id    | INT           | Employee identifier   |
| salary         | DECIMAL(10,2) | Historical salary     |
| effective_date | DATE          | Salary effective date |

## 🔍 SQL Concepts Covered

This project demonstrates a wide range of SQL concepts.

### Basic SQL

* `CREATE DATABASE`
* `USE`
* `CREATE TABLE`
* `INSERT INTO`
* `SELECT`
* `WHERE`
* `ORDER BY`
* `LIMIT`

### Aggregate Functions

* `COUNT()`
* `SUM()`
* `AVG()`
* `MAX()`
* `MIN()`

### Grouping

* `GROUP BY`
* `HAVING`

### Joins

* `INNER JOIN`
* `LEFT JOIN`

Example:

```sql
SELECT e.employee_name,
       d.department_name,
       e.salary
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

### Subqueries

The project includes queries for:

* Finding the second-highest salary
* Employees earning above average salary
* Employees earning above their department average

### CTE

A Common Table Expression is used to identify employees with salaries above ₹80,000:

```sql
WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 80000
)
SELECT *
FROM high_salary;
```

## 📈 Advanced SQL

The project also demonstrates advanced analytical SQL techniques.

### Window Functions

#### RANK()

Used for ranking employees based on salary within departments.

```sql
RANK() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
)
```

#### DENSE_RANK()

Used to identify the top employees within each department.

#### ROW_NUMBER()

Used for assigning sequential numbers within employee groups.

#### Running Totals

The project calculates cumulative salary and transaction values using:

```sql
SUM(amount) OVER (
    PARTITION BY customer_id
    ORDER BY transaction_date
)
```

#### LAG() and LEAD()

Used to compare transactions with previous and subsequent transactions.

```sql
LAG(amount) OVER (
    PARTITION BY customer_id
    ORDER BY transaction_date
)
```

```sql
LEAD(amount) OVER (
    PARTITION BY customer_id
    ORDER BY transaction_date
)
```

## 📊 Analysis Performed

The SQL task includes analysis such as:

* Employee count by department
* Average salary by department
* Highest and lowest salaries
* Second-highest salary
* Employees without departments
* Employees assigned to multiple projects
* Total project cost per employee
* Departments with specific employee counts
* Employees earning above average salary
* Salary rankings within departments
* Top employees by department
* Customer transaction totals
* Highest transaction per customer
* Monthly transaction analysis
* Customer ranking by monthly transaction amount
* Running transaction totals
* Cumulative project costs
* Previous and next transaction comparisons
* Data-quality checks for invalid transaction values

These analytical queries form the main task component of the project.

## 🧪 Data Validation

The project also includes a basic data-quality check for:

* NULL transaction amounts
* NULL customer IDs
* Negative transaction amounts

```sql
SELECT *
FROM transactions
WHERE amount IS NULL
   OR customer_id IS NULL
   OR amount < 0;
```

## 🚀 How to Run

### 1. Install MySQL

Install:

* MySQL Server
* MySQL Workbench

### 2. Open MySQL Workbench

Connect to your local MySQL server.

### 3. Open the SQL file

Open:
[Enterprise_Management_System](https://github.com/apurvakesarkar46/Enterprise-Management-System-SQL/commit/c6d8219ccf1e371454edb80a463f88b489467893)

### 4. Execute the script

Run the complete SQL script.

The script will:

1. Create the database.
2. Select the database.
3. Create the required tables.
4. Insert sample data.
5. Execute SQL queries for analysis.

### 5. Verify the Database

Run:

```sql
USE Enterprise_Management_System;

SHOW TABLES;
```

Expected tables:

```text
departments
employees
projects
customers
transactions
employee_history
```

## 📁 Repository Structure

```text
Enterprise-Management-System-SQL/
│
├── Enterprise_Management_System.sql
├── queries.pdf
├── queries with outputs.pdf
├── output.png
├── query-1.png
├── query-2.png
└── README.md
```

## 💡 Key Learning Outcomes

Through this task, I practiced:

* Relational database design
* Primary and foreign keys
* Data insertion and retrieval
* SQL joins
* Aggregate functions
* Grouping and filtering
* Subqueries
* Common Table Expressions
* Window functions
* Ranking techniques
* Running totals
* Transaction analysis
* Data validation
* Business-oriented SQL analysis

## 🎓 Project Type

**SQL / Database Management Task**

This project was created as a practical exercise to strengthen **MySQL, SQL querying, data analysis, and relational database concepts**.

## Author

**Apurva Kesarkar**

Computer Science Engineering Student

- LinkedIn: [Apurva Kesarkar](https://www.linkedin.com/in/apurva-kesarkar-8004a5422)
- GitHub: [Apurva Kesarkar](https://github.com/apurvakesarkar46)

---

