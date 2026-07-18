/*
============================================================
PROJECT  : Workforce Performance Analytics
MODULE   : 03 - Salary Analysis
AUTHOR   : Rahul Kumar
DATABASE : HR
TABLE    : hr_employee_data

DESCRIPTION:
This module analyzes employee salaries across departments,
job roles, education levels and identifies top earners
using advanced SQL ranking functions.

============================================================
*/

USE HR;

-- ==========================================================
-- Q1. What is the average salary of the company?
-- ==========================================================

SELECT
    ROUND(AVG(Salary),2) AS Average_Salary
FROM hr_employee_data;


-- ==========================================================
-- Q2. What is the highest and lowest salary?
-- ==========================================================

SELECT
    MAX(Salary) AS Highest_Salary,
    MIN(Salary) AS Lowest_Salary
FROM hr_employee_data;


-- ==========================================================
-- Q3. Top 10 Highest Paid Employees
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    JobRole,
    Salary
FROM hr_employee_data
ORDER BY Salary DESC
LIMIT 10;


-- ==========================================================
-- Q4. Top 10 Lowest Paid Employees
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    JobRole,
    Salary
FROM hr_employee_data
ORDER BY Salary
LIMIT 10;


-- ==========================================================
-- Q5. Average Salary by Department
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(Salary),2) AS Average_Salary
FROM hr_employee_data
GROUP BY Department
ORDER BY Average_Salary DESC;


-- ==========================================================
-- Q6. Average Salary by Job Role
-- ==========================================================

SELECT
    JobRole,
    ROUND(AVG(Salary),2) AS Average_Salary
FROM hr_employee_data
GROUP BY JobRole
ORDER BY Average_Salary DESC;


-- ==========================================================
-- Q7. Average Salary by Education Level
-- ==========================================================

SELECT
    EducationLevel,
    ROUND(AVG(Salary),2) AS Average_Salary
FROM hr_employee_data
GROUP BY EducationLevel
ORDER BY Average_Salary DESC;


-- ==========================================================
-- Q8. Salary Distribution by Gender
-- ==========================================================

SELECT
    Gender,
    ROUND(AVG(Salary),2) AS Average_Salary
FROM hr_employee_data
GROUP BY Gender;


-- ==========================================================
-- Q9. Rank Employees by Salary
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Salary,
    DENSE_RANK() OVER(ORDER BY Salary DESC) AS Salary_Rank
FROM hr_employee_data;


-- ==========================================================
-- Q10. Rank Employees Within Each Department
-- ==========================================================

SELECT
    Department,
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Salary,
    DENSE_RANK() OVER(
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS Department_Rank
FROM hr_employee_data;


-- ==========================================================
-- Q11. Categorize Employees into Salary Bands
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Salary,

    CASE
        WHEN Salary < 5000 THEN 'Low Salary'
        WHEN Salary BETWEEN 5000 AND 10000 THEN 'Medium Salary'
        WHEN Salary BETWEEN 10001 AND 15000 THEN 'High Salary'
        ELSE 'Executive Salary'
    END AS Salary_Band

FROM hr_employee_data;


-- ==========================================================
-- Q12. Salary Band Distribution
-- ==========================================================

SELECT

    CASE
        WHEN Salary < 5000 THEN 'Low Salary'
        WHEN Salary BETWEEN 5000 AND 10000 THEN 'Medium Salary'
        WHEN Salary BETWEEN 10001 AND 15000 THEN 'High Salary'
        ELSE 'Executive Salary'
    END AS Salary_Band,

    COUNT(*) AS Total_Employees

FROM hr_employee_data

GROUP BY Salary_Band

ORDER BY Total_Employees DESC;