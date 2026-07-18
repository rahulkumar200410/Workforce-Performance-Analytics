/*
============================================================
PROJECT  : Workforce Performance Analytics
MODULE   : 05 - Employee Satisfaction Analysis
AUTHOR   : Rahul Kumar
DATABASE : HR
TABLE    : hr_employee_data

DESCRIPTION:
This module analyzes employee satisfaction across different
dimensions including job satisfaction, work-life balance,
environment satisfaction and relationship satisfaction.

============================================================
*/

USE HR;

-- ==========================================================
-- Q1. What is the average Job Satisfaction?
-- ==========================================================

SELECT
    ROUND(AVG(JobSatisfaction),2) AS Average_Job_Satisfaction
FROM hr_employee_data;


-- ==========================================================
-- Q2. What is the average Environment Satisfaction?
-- ==========================================================

SELECT
    ROUND(AVG(EnvironmentSatisfaction),2) AS Average_Environment_Satisfaction
FROM hr_employee_data;


-- ==========================================================
-- Q3. What is the average Relationship Satisfaction?
-- ==========================================================

SELECT
    ROUND(AVG(RelationshipSatisfaction),2) AS Average_Relationship_Satisfaction
FROM hr_employee_data;


-- ==========================================================
-- Q4. What is the average Work-Life Balance?
-- ==========================================================

SELECT
    ROUND(AVG(WorkLifeBalance),2) AS Average_Work_Life_Balance
FROM hr_employee_data;


-- ==========================================================
-- Q5. Which department has the highest Job Satisfaction?
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(JobSatisfaction),2) AS Average_Job_Satisfaction
FROM hr_employee_data
GROUP BY Department
ORDER BY Average_Job_Satisfaction DESC;


-- ==========================================================
-- Q6. Which department has the highest Environment Satisfaction?
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(EnvironmentSatisfaction),2) AS Average_Environment_Satisfaction
FROM hr_employee_data
GROUP BY Department
ORDER BY Average_Environment_Satisfaction DESC;


-- ==========================================================
-- Q7. Which department has the best Work-Life Balance?
-- ==========================================================

SELECT
    Department,
    ROUND(AVG(WorkLifeBalance),2) AS Average_Work_Life_Balance
FROM hr_employee_data
GROUP BY Department
ORDER BY Average_Work_Life_Balance DESC;


-- ==========================================================
-- Q8. Satisfaction by Job Role
-- ==========================================================

SELECT
    JobRole,
    ROUND(AVG(JobSatisfaction),2) AS Average_Job_Satisfaction
FROM hr_employee_data
GROUP BY JobRole
ORDER BY Average_Job_Satisfaction DESC;


-- ==========================================================
-- Q9. Work-Life Balance by Job Role
-- ==========================================================

SELECT
    JobRole,
    ROUND(AVG(WorkLifeBalance),2) AS Average_Work_Life_Balance
FROM hr_employee_data
GROUP BY JobRole
ORDER BY Average_Work_Life_Balance DESC;


-- ==========================================================
-- Q10. Compare Job Satisfaction of employees who left vs stayed
-- ==========================================================

SELECT
    Attrition,
    ROUND(AVG(JobSatisfaction),2) AS Average_Job_Satisfaction
FROM hr_employee_data
GROUP BY Attrition;


-- ==========================================================
-- Q11. Compare Work-Life Balance of employees who left vs stayed
-- ==========================================================

SELECT
    Attrition,
    ROUND(AVG(WorkLifeBalance),2) AS Average_Work_Life_Balance
FROM hr_employee_data
GROUP BY Attrition;


-- ==========================================================
-- Q12. Top 10 Most Satisfied Employees
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS Employee_Name,
    Department,
    JobRole,
    JobSatisfaction,
    WorkLifeBalance
FROM hr_employee_data
ORDER BY JobSatisfaction DESC,
         WorkLifeBalance DESC
LIMIT 10;