/*
============================================================
PROJECT  : Workforce Performance Analytics
MODULE   : 06 - Promotion & Experience Analysis
AUTHOR   : Rahul Kumar
DATABASE : HR
TABLE    : hr_employee_data

DESCRIPTION:
This module analyzes employee experience, promotions,
tenure, and manager relationships.

============================================================
*/

USE HR;

-- ==========================================================
-- Q1. What is the average Years at Company?
-- ==========================================================

SELECT
    ROUND(AVG(YearsAtCompany),2) AS Average_Years_At_Company
FROM hr_employee_data;


-- ==========================================================
-- Q2. What is the average Years Since Last Promotion?
-- ==========================================================

SELECT
    ROUND(AVG(YearsSinceLastPromotion),2) AS Avg_Years_Since_Last_Promotion
FROM hr_employee_data;


-- ==========================================================
-- Q3. Which departments have employees waiting the longest
--     for promotion?
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(YearsSinceLastPromotion),2) AS Avg_Years_Waiting
FROM hr_employee_data
GROUP BY Department
ORDER BY Avg_Years_Waiting DESC;


-- ==========================================================
-- Q4. Which job roles wait the longest for promotion?
-- ==========================================================

SELECT
    JobRole,
    ROUND(AVG(YearsSinceLastPromotion),2) AS Avg_Years_Waiting
FROM hr_employee_data
GROUP BY JobRole
ORDER BY Avg_Years_Waiting DESC;


-- ==========================================================
-- Q5. Top 10 employees waiting longest for promotion
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    JobRole,
    YearsSinceLastPromotion
FROM hr_employee_data
ORDER BY YearsSinceLastPromotion DESC
LIMIT 10;


-- ==========================================================
-- Q6. Employees with more than 10 years in the company
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    YearsAtCompany
FROM hr_employee_data
WHERE YearsAtCompany > 10
ORDER BY YearsAtCompany DESC;


-- ==========================================================
-- Q7. Employees working with the same manager for the
--     longest time
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    YearsWithCurrManager
FROM hr_employee_data
ORDER BY YearsWithCurrManager DESC
LIMIT 10;


-- ==========================================================
-- Q8. Average Years with Current Manager by Department
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(YearsWithCurrManager),2) AS Avg_Years_With_Manager
FROM hr_employee_data
GROUP BY Department
ORDER BY Avg_Years_With_Manager DESC;


-- ==========================================================
-- Q9. Employees due for promotion
-- (Waiting >= 5 years)
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    JobRole,
    YearsSinceLastPromotion
FROM hr_employee_data
WHERE YearsSinceLastPromotion >= 5
ORDER BY YearsSinceLastPromotion DESC;


-- ==========================================================
-- Q10. Promotion Status using CASE WHEN
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    YearsSinceLastPromotion,

    CASE
        WHEN YearsSinceLastPromotion >= 5 THEN 'Promotion Due'
        WHEN YearsSinceLastPromotion BETWEEN 3 AND 4 THEN 'Promotion Soon'
        ELSE 'Recently Promoted'
    END AS Promotion_Status

FROM hr_employee_data;


-- ==========================================================
-- Q11. Promotion Status Distribution
-- ==========================================================

SELECT

    CASE
        WHEN YearsSinceLastPromotion >= 5 THEN 'Promotion Due'
        WHEN YearsSinceLastPromotion BETWEEN 3 AND 4 THEN 'Promotion Soon'
        ELSE 'Recently Promoted'
    END AS Promotion_Status,

    COUNT(*) AS Total_Employees

FROM hr_employee_data

GROUP BY Promotion_Status

ORDER BY Total_Employees DESC;


-- ==========================================================
-- Q12. Department-wise Promotion Due Employees
-- ==========================================================

SELECT
    Department,
    COUNT(*) AS Promotion_Due

FROM hr_employee_data

WHERE YearsSinceLastPromotion >=5

GROUP BY Department

ORDER BY Promotion_Due DESC;