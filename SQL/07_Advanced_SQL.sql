/*
============================================================
PROJECT  : Workforce Performance Analytics
MODULE   : 07 - Advanced SQL
AUTHOR   : Rahul Kumar
DATABASE : HR
TABLE    : hr_employee_data

DESCRIPTION:
This module demonstrates advanced SQL concepts including
CTEs, Window Functions, Ranking Functions and Views.

============================================================
*/

USE HR;

-- ==========================================================
-- Q1. Rank employees by salary using RANK()
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    Salary,
    RANK() OVER(
        ORDER BY Salary DESC
    ) AS Salary_Rank
FROM hr_employee_data;


-- ==========================================================
-- Q2. Rank employees by salary using DENSE_RANK()
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    Salary,
    DENSE_RANK() OVER(
        ORDER BY Salary DESC
    ) AS Salary_Rank
FROM hr_employee_data;


-- ==========================================================
-- Q3. Assign row numbers to employees
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Salary,
    ROW_NUMBER() OVER(
        ORDER BY Salary DESC
    ) AS Row_Num
FROM hr_employee_data;


-- ==========================================================
-- Q4. Rank employees within each department
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
-- Q5. Department-wise highest salary using CTE
-- ==========================================================

WITH DepartmentSalary AS
(
    SELECT
        Department,
        MAX(Salary) AS Highest_Salary
    FROM hr_employee_data
    GROUP BY Department
)

SELECT *
FROM DepartmentSalary;


-- ==========================================================
-- Q6. Employees earning more than department average
-- ==========================================================

WITH DepartmentAverage AS
(
    SELECT
        Department,
        AVG(Salary) AS Avg_Salary
    FROM hr_employee_data
    GROUP BY Department
)

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS Employee_Name,
    e.Department,
    e.Salary

FROM hr_employee_data e

JOIN DepartmentAverage d

ON e.Department=d.Department

WHERE e.Salary>d.Avg_Salary;


-- ==========================================================
-- Q7. Running Total of Salary
-- ==========================================================

SELECT

    EmployeeID,

    Salary,

    SUM(Salary)
    OVER(
        ORDER BY Salary
    ) AS Running_Total

FROM hr_employee_data;


-- ==========================================================
-- Q8. Previous Salary using LAG()
-- ==========================================================

SELECT

    EmployeeID,

    Salary,

    LAG(Salary)
    OVER(
        ORDER BY Salary
    ) AS Previous_Salary

FROM hr_employee_data;


-- ==========================================================
-- Q9. Next Salary using LEAD()
-- ==========================================================

SELECT

    EmployeeID,

    Salary,

    LEAD(Salary)
    OVER(
        ORDER BY Salary
    ) AS Next_Salary

FROM hr_employee_data;


-- ==========================================================
-- Q10. Highest Paid Employee in each Department
-- ==========================================================

WITH RankedEmployees AS
(
    SELECT

        EmployeeID,

        CONCAT(FirstName,' ',LastName) AS Employee_Name,

        Department,

        Salary,

        DENSE_RANK()
        OVER(
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS Salary_Rank

    FROM hr_employee_data
)

SELECT *

FROM RankedEmployees

WHERE Salary_Rank=1;


-- ==========================================================
-- Q11. Salary Percentage Contribution
-- ==========================================================

SELECT

    Department,

    SUM(Salary) AS Department_Salary,

    ROUND(
        SUM(Salary)*100/
        (SELECT SUM(Salary)
        FROM hr_employee_data),
        2
    ) AS Salary_Percentage

FROM hr_employee_data

GROUP BY Department

ORDER BY Salary_Percentage DESC;


-- ==========================================================
-- Q12. Department-wise Employee Count Ranking
-- ==========================================================

SELECT

    Department,

    COUNT(*) AS Total_Employees,

    DENSE_RANK()
    OVER(
        ORDER BY COUNT(*) DESC
    ) AS Department_Rank

FROM hr_employee_data

GROUP BY Department;