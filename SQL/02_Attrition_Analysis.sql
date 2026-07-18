/*
============================================================
PROJECT  : Workforce Performance Analytics
MODULE   : 02 - Attrition Analysis
AUTHOR   : Rahul Kumar sao
DATABASE : HR
TABLE    : hr_employee_data

DESCRIPTION:
This module analyzes employee attrition across different
business dimensions such as department, job role, salary,
gender, overtime, education, and age groups.

============================================================
*/

USE HR;

-- ==========================================================
-- Q1. What is the overall employee attrition rate?
-- ==========================================================

SELECT
    Attrition,
    COUNT(*) AS Total_Employees,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM hr_employee_data),
        2
    ) AS Attrition_Percentage
FROM hr_employee_data
GROUP BY Attrition;


-- ==========================================================
-- Q2. Which departments have the highest attrition?
-- ==========================================================

SELECT
    Department,
    COUNT(*) AS Employees_Left
FROM hr_employee_data
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY Employees_Left DESC;


-- ==========================================================
-- Q3. Which job roles have the highest attrition?
-- ==========================================================

SELECT
    JobRole,
    COUNT(*) AS Employees_Left
FROM hr_employee_data
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY Employees_Left DESC;


-- ==========================================================
-- Q4. Does overtime increase attrition?
-- ==========================================================

SELECT
    OverTime,
    Attrition,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY OverTime, Attrition
ORDER BY OverTime;


-- ==========================================================
-- Q5. Attrition by Gender
-- ==========================================================

SELECT
    Gender,
    Attrition,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY Gender, Attrition
ORDER BY Gender;


-- ==========================================================
-- Q6. Attrition by Education Level
-- ==========================================================

SELECT
    EducationLevel,
    Attrition,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY EducationLevel, Attrition
ORDER BY EducationLevel;


-- ==========================================================
-- Q7. Attrition by Marital Status
-- ==========================================================

SELECT
    MaritalStatus,
    Attrition,
    COUNT(*) AS Total_Employees
FROM hr_employee_data
GROUP BY MaritalStatus, Attrition
ORDER BY MaritalStatus;


-- ==========================================================
-- Q8. Attrition by State
-- ==========================================================

SELECT
    State,
    COUNT(*) AS Employees_Left
FROM hr_employee_data
WHERE Attrition = 'Yes'
GROUP BY State
ORDER BY Employees_Left DESC;


-- ==========================================================
-- Q9. Attrition by Salary Band (CASE WHEN)
-- ==========================================================

SELECT
    CASE
        WHEN Salary < 5000 THEN 'Low Salary'
        WHEN Salary BETWEEN 5000 AND 10000 THEN 'Medium Salary'
        ELSE 'High Salary'
    END AS Salary_Band,

    COUNT(*) AS Employees_Left

FROM hr_employee_data

WHERE Attrition='Yes'

GROUP BY Salary_Band

ORDER BY Employees_Left DESC;


-- ==========================================================
-- Q10. Attrition by Age Group (CASE WHEN)
-- ==========================================================

SELECT

    CASE

        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Above 50'

    END AS Age_Group,

    COUNT(*) AS Employees_Left

FROM hr_employee_data

WHERE Attrition='Yes'

GROUP BY Age_Group

ORDER BY Employees_Left DESC;


-- ==========================================================
-- Q11. Attrition by Years at Company
-- ==========================================================

SELECT

    YearsAtCompany,

    COUNT(*) AS Employees_Left

FROM hr_employee_data

WHERE Attrition='Yes'

GROUP BY YearsAtCompany

ORDER BY YearsAtCompany;


-- ==========================================================
-- Q12. Top 5 Departments with Highest Attrition Rate
-- ==========================================================

SELECT

    Department,

    COUNT(*) AS Employees_Left,

    ROUND(
        COUNT(*)*100.0/
        (SELECT COUNT(*)
         FROM hr_employee_data
         WHERE Attrition='Yes'),
        2
    ) AS Percentage

FROM hr_employee_data

WHERE Attrition='Yes'

GROUP BY Department

ORDER BY Employees_Left DESC

LIMIT 5;