/*
============================================================
PROJECT  : Workforce Performance Analytics
MODULE   : 01 - Workforce Overview
AUTHOR   : Rahul Kumar sao
DATABASE : HR
TABLE    : hr_employee_data

DESCRIPTION:
This module provides an overview of the workforce by analyzing
employee distribution, demographics, salary, and tenure.

============================================================
*/

USE HR;

-- ==========================================================
-- Q1. How many employees are currently working in the company?
-- ==========================================================

SELECT
    COUNT(*) AS Total_Employees
FROM hr_employee_data;


-- ==========================================================
-- Q2. How many employees are there in each department?
-- ==========================================================

SELECT
    Department,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY Department
ORDER BY Total_Employees DESC;


-- ==========================================================
-- Q3. Which job roles have the highest number of employees?
-- ==========================================================

SELECT
    JobRole,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY JobRole
ORDER BY Total_Employees DESC;


-- ==========================================================
-- Q4. What is the gender distribution across the company?
-- ==========================================================

SELECT
    Gender,
    COUNT(*) AS Total_Employees,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM hr_employee_data),
        2
    ) AS Percentage
FROM hr_employee_data
GROUP BY Gender
ORDER BY Total_Employees DESC;


-- ==========================================================
-- Q5. What is the average salary in each department?
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(Salary),2) AS Average_Salary
FROM hr_employee_data
GROUP BY Department
ORDER BY Average_Salary DESC;


-- ==========================================================
-- Q6. Which departments have the highest total salary expense?
-- ==========================================================

SELECT
    Department,
    SUM(Salary) AS Total_Salary_Expense
FROM hr_employee_data
GROUP BY Department
ORDER BY Total_Salary_Expense DESC;


-- ==========================================================
-- Q7. What is the average employee age in each department?
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(Age),2) AS Average_Age
FROM hr_employee_data
GROUP BY Department
ORDER BY Average_Age DESC;


-- ==========================================================
-- Q8. What is the average employee tenure in each department?
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(YearsAtCompany),2) AS Average_Tenure
FROM hr_employee_data
GROUP BY Department
ORDER BY Average_Tenure DESC;


-- ==========================================================
-- Q9. What is the average salary for each job role?
-- ==========================================================

SELECT
    JobRole,
    ROUND(AVG(Salary),2) AS Average_Salary
FROM hr_employee_data
GROUP BY JobRole
ORDER BY Average_Salary DESC;


-- ==========================================================
-- Q10. Which states have the highest number of employees?
-- ==========================================================

SELECT
    State,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY State
ORDER BY Total_Employees DESC;


-- ==========================================================
-- Q11. What is the education level distribution?
-- ==========================================================

SELECT
    EducationLevel,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY EducationLevel
ORDER BY Total_Employees DESC;


-- ==========================================================
-- Q12. What is the marital status distribution?
-- ==========================================================

SELECT
    MaritalStatus,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY MaritalStatus
ORDER BY Total_Employees DESC;