/*
============================================================
PROJECT  : Workforce Performance Analytics
MODULE   : 04 - Performance Analysis
AUTHOR   : Rahul Kumar
DATABASE : HR
TABLE    : hr_employee_data

DESCRIPTION:
This module evaluates employee performance, manager ratings,
training opportunities, and identifies high-performing
employees.

============================================================
*/

USE HR;

-- ==========================================================
-- Q1. What is the average self-rating and manager rating?
-- ==========================================================

SELECT
    ROUND(AVG(SelfRating),2) AS Avg_Self_Rating,
    ROUND(AVG(ManagerRating),2) AS Avg_Manager_Rating
FROM hr_employee_data;


-- ==========================================================
-- Q2. Average self-rating by department
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(SelfRating),2) AS Avg_Self_Rating
FROM hr_employee_data
GROUP BY Department
ORDER BY Avg_Self_Rating DESC;


-- ==========================================================
-- Q3. Average manager rating by department
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(ManagerRating),2) AS Avg_Manager_Rating
FROM hr_employee_data
GROUP BY Department
ORDER BY Avg_Manager_Rating DESC;


-- ==========================================================
-- Q4. Top 10 employees based on manager rating
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    JobRole,
    ManagerRating
FROM hr_employee_data
ORDER BY ManagerRating DESC
LIMIT 10;


-- ==========================================================
-- Q5. Top 10 employees based on self-rating
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    JobRole,
    SelfRating
FROM hr_employee_data
ORDER BY SelfRating DESC
LIMIT 10;


-- ==========================================================
-- Q6. Average training opportunities by department
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(TrainingOpportunitiesWithinYear),2) AS Avg_Training
FROM hr_employee_data
GROUP BY Department
ORDER BY Avg_Training DESC;


-- ==========================================================
-- Q7. Employees whose self-rating is higher than manager rating
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    SelfRating,
    ManagerRating
FROM hr_employee_data
WHERE SelfRating > ManagerRating
ORDER BY SelfRating DESC;


-- ==========================================================
-- Q8. Employees whose manager rating is higher than self-rating
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    SelfRating,
    ManagerRating
FROM hr_employee_data
WHERE ManagerRating > SelfRating
ORDER BY ManagerRating DESC;


-- ==========================================================
-- Q9. Department-wise highest manager rating
-- ==========================================================

SELECT
    Department,
    MAX(ManagerRating) AS Highest_Manager_Rating
FROM hr_employee_data
GROUP BY Department
ORDER BY Highest_Manager_Rating DESC;


-- ==========================================================
-- Q10. Rank employees based on manager rating
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    ManagerRating,
    DENSE_RANK() OVER(
        ORDER BY ManagerRating DESC
    ) AS Performance_Rank
FROM hr_employee_data;


-- ==========================================================
-- Q11. Rank employees within each department
-- ==========================================================

SELECT
    Department,
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    ManagerRating,
    DENSE_RANK() OVER(
        PARTITION BY Department
        ORDER BY ManagerRating DESC
    ) AS Department_Performance_Rank
FROM hr_employee_data;


-- ==========================================================
-- Q12. Employees with highest training opportunities
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    TrainingOpportunitiesWithinYear
FROM hr_employee_data
ORDER BY TrainingOpportunitiesWithinYear DESC
LIMIT 10;