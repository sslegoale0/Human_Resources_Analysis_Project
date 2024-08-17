SET sql_safe_update = 0;

SET sql_mode = "Traditional";

/* ---------------------------------------------------------------------------------------------------------------------------- */

/* Human Resources Data Cleaning */

CREATE DATABASE human_resources;



USE human_resources;



SELECT *
FROM employees;



DESCRIBE employees;


/* 1. Removal of duplicate rows. */

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY
`Attrition`,
`Business Travel`,
`CF_age band`,
`CF_attrition label`,
`Department`,
`Education Field`,
`emp no`,
`Employee Number`,
`Gender`,
`Job Role`,
`Marital Status`,
`Over Time`,
`Over18`,
`Training Times Last Year`,
`Age`,
`CF_current Employee`,
`Daily Rate`,
`Distance From Home`,
`Education`,
`Employee Count`,
`Environment Satisfaction`,
`Hourly Rate`,
`Job Involvement`,
`Job Level`,
`Job Satisfaction`,
`Monthly Income`,
`Monthly Rate`,
`Num Companies Worked`,
`Percent Salary Hike`,
`Performance Rating`,
`Relationship Satisfaction`,
`Standard Hours`,
`Stock Option Level`,
`Total Working Years`,
`Work Life Balance`,
`Years At Company`,
`Years In Current Role`,
`Years Since Last Promotion`,
`Years With Curr Manager`
ORDER BY `Employee Number`) AS "Row Number"
FROM employees;



WITH employee_duplicates AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY
`Attrition`,
`Business Travel`,
`CF_age band`,
`CF_attrition label`,
`Department`,
`Education Field`,
`emp no`,
`Employee Number`,
`Gender`,
`Job Role`,
`Marital Status`,
`Over Time`,
`Over18`,
`Training Times Last Year`,
`Age`,
`CF_current Employee`,
`Daily Rate`,
`Distance From Home`,
`Education`,
`Employee Count`,
`Environment Satisfaction`,
`Hourly Rate`,
`Job Involvement`,
`Job Level`,
`Job Satisfaction`,
`Monthly Income`,
`Monthly Rate`,
`Num Companies Worked`,
`Percent Salary Hike`,
`Performance Rating`,
`Relationship Satisfaction`,
`Standard Hours`,
`Stock Option Level`,
`Total Working Years`,
`Work Life Balance`,
`Years At Company`,
`Years In Current Role`,
`Years Since Last Promotion`,
`Years With Curr Manager`
ORDER BY `Employee Number`) AS "Row Number"
FROM employees)
SELECT *
FROM employee_duplicates
WHERE `Row Number` > 1;



/* 2. Data formatting & standardisation. */

SELECT DISTINCT `Attrition`
FROM employees
ORDER BY `Attrition` ASC;



SELECT DISTINCT `Business Travel`
FROM employees
ORDER BY `Business Travel` ASC;

SELECT DISTINCT `Business Travel`,
REPLACE(`Business Travel`, '_', ' ')
FROM employees;

UPDATE employees
SET `Business Travel` = REPLACE(`Business Travel`, '_', ' ');



SELECT DISTINCT `CF_age band`
FROM employees
ORDER BY `CF_age band` ASC;

SELECT DISTINCT `Age`,
`CF_age band`
FROM employees
ORDER BY `Age`;



SELECT DISTINCT `CF_attrition label`
FROM employees
ORDER BY `CF_attrition label` ASC;



SELECT DISTINCT `Education Field`
FROM employees
ORDER BY `Education Field` ASC;



SELECT DISTINCT `emp no`
FROM employees
ORDER BY `emp no` ASC;



SELECT DISTINCT `Employee Number`
FROM employees
ORDER BY `Employee Number` ASC;



SELECT DISTINCT `Gender`
FROM employees
ORDER BY `Gender` ASC;



SELECT DISTINCT `Job Role`
FROM employees
ORDER BY `Job Role` ASC;



SELECT DISTINCT `Marital Status`
FROM employees
ORDER BY `Marital Status` ASC;



SELECT DISTINCT `Over Time`
FROM employees
ORDER BY `Over Time` ASC;



SELECT DISTINCT `Over18`
FROM employees
ORDER BY `Over18` ASC;



SELECT DISTINCT `Training Times Last Year`
FROM employees
ORDER BY `Training Times Last Year` ASC;



SELECT DISTINCT `Age`
FROM employees
ORDER BY `Age` ASC;



SELECT DISTINCT `CF_current Employee`
FROM employees
ORDER BY `CF_current Employee` ASC;



SELECT DISTINCT `Distance From Home`
FROM employees
ORDER BY `Distance From Home` ASC;



SELECT DISTINCT `Education`
FROM employees
ORDER BY `Education` ASC;



SELECT DISTINCT `Employee Count`
FROM employees
ORDER BY `Employee Count` ASC;



SELECT DISTINCT `Environment Satisfaction`
FROM employees
ORDER BY `Environment Satisfaction` ASC;



SELECT DISTINCT `Hourly Rate`
FROM employees
ORDER BY `Hourly Rate` ASC;



SELECT DISTINCT `Job Involvement`
FROM employees
ORDER BY `Job Involvement` ASC;



SELECT DISTINCT `Job Level`
FROM employees
ORDER BY `Job Level` ASC;



SELECT DISTINCT `Job Satisfaction`
FROM employees
ORDER BY `Job Satisfaction` ASC;



SELECT DISTINCT `Monthly Income`
FROM employees
ORDER BY `Monthly Income` ASC;



SELECT DISTINCT `Monthly Rate`
FROM employees
ORDER BY `Monthly Rate` ASC;



SELECT DISTINCT `Num Companies Worked`
FROM employees
ORDER BY `Num Companies Worked` ASC;



SELECT DISTINCT `Percent Salary Hike`
FROM employees
ORDER BY `Percent Salary Hike` ASC;



SELECT DISTINCT `Performance Rating`
FROM employees
ORDER BY `Performance Rating` ASC;



SELECT DISTINCT `Relationship Satisfaction`
FROM employees
ORDER BY `Relationship Satisfaction` ASC;



SELECT DISTINCT `Standard Hours`
FROM employees
ORDER BY `Standard Hours` ASC;



SELECT DISTINCT `Stock Option Level`
FROM employees
ORDER BY `Stock Option Level` ASC;



SELECT DISTINCT `Total Working Years`
FROM employees
ORDER BY `Total Working Years` ASC;



SELECT DISTINCT `Work Life Balance`
FROM employees
ORDER BY `Work Life Balance` ASC;



SELECT DISTINCT `Years At Company`
FROM employees
ORDER BY `Years At Company` ASC;



SELECT DISTINCT `Years In Current Role`
FROM employees
ORDER BY `Years In Current Role` ASC;



SELECT DISTINCT `Years Since Last Promotion`
FROM employees
ORDER BY `Years Since Last Promotion` ASC;



SELECT DISTINCT `Years With Curr Manager`
FROM employees
ORDER BY `Years With Curr Manager` ASC;

ALTER TABLE employees
RENAME COLUMN `Years With Curr Manager` TO `Years With Current Manager`;

SELECT DISTINCT `Years With Current Manager`
FROM employees
ORDER BY `Years With Current Manager` ASC;



/* 3. Imputation of blank/null values. */

-- There are no null or blank values in the dataset. 



/* 4. Removal of irrelevant/redundant columns. */

ALTER TABLE employees
DROP COLUMN `CF_age band`,
DROP COLUMN `CF_attrition label`,
DROP COLUMN `emp no`,
DROP COLUMN `Over18`,
DROP COLUMN `CF_current Employee`,
DROP COLUMN `Employee Count`;



/* --------------------------------------------------------------------------------------------------------------- */

/* Human Resources Data Analysis */

/* 1. Total Employees */

SELECT COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees



/* 2. Current Employees */

SELECT DISTINCT 
(SELECT COUNT(DISTINCT `Employee Number`)
FROM employees
WHERE `Attrition` = 'No') AS "Current Employees",
ROUND((CAST((SELECT COUNT(DISTINCT `Employee Number`)
FROM employees
WHERE `Attrition` = 'No') AS FLOAT) * 100
/
COUNT(DISTINCT `Employee Number`)), 2) AS "% of Current Employees"
FROM employees;



/* 3. Former Employees */

SELECT DISTINCT 
(SELECT COUNT(DISTINCT `Employee Number`)
FROM employees
WHERE `Attrition` = 'Yes') AS "Current Employees",
ROUND((CAST((SELECT COUNT(DISTINCT `Employee Number`)
FROM employees
WHERE `Attrition` = 'Yes') AS FLOAT) * 100
/
COUNT(DISTINCT `Employee Number`)), 2) AS "% of Current Employees"
FROM employees;



/* 4. Average Employment Length */

SELECT ROUND(AVG(`Years At Company`), 2) AS "Average Age of Employees"
FROM employees;



/* 5. Average Age of Employees */

SELECT ROUND(AVG(`Age`), 2) AS "Average Age of Employees"
FROM employees;



/* 6. Total Employees by Gender */

SELECT `Gender`, 
COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees
GROUP BY `Gender`;



/* 7. Current Employees by Gender */

SELECT `Gender`, 
COUNT(DISTINCT `Employee Number`) AS "Current Employees"
FROM employees
WHERE `Attrition` = 'No'
GROUP BY `Gender`;



/* 8. Former Employees by Gender */

SELECT `Gender`, 
COUNT(DISTINCT `Employee Number`) AS "Former Employees"
FROM employees
WHERE `Attrition` = 'Yes'
GROUP BY `Gender`;

-- Age Group column

ALTER TABLE employees
ADD `Age Group` NVARCHAR(255);

UPDATE employees
SET `Age Group` = CASE
WHEN `Age` IN (18, 19, 20, 21, 22, 23, 24) THEN '18+'
WHEN `Age` IN (25, 26, 27, 28, 29, 30, 31, 32, 33, 34) THEN '25 - 34'
WHEN `Age` IN (35, 36, 37, 38, 39, 40, 41, 42, 43, 44) THEN '35 - 44'
WHEN `Age` IN (45, 46, 47, 48, 49, 50, 51, 52, 53, 54) THEN '45 -54'
WHEN `Age` IN (55, 56, 57, 58, 59, 60) THEN '55+'
END;



/* 9. Total Employees by Age Groups */

SELECT `Age Group`, 
COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees
GROUP BY `Age Group`;



/* 10. Current Employees by Age Groups */

SELECT `Age Group`, 
COUNT(DISTINCT `Employee Number`) AS "Current Employees"
FROM employees
WHERE `Attrition` = 'No'
GROUP BY `Age Group`;



/* 11. Former Employees by Age Groups */

SELECT `Age Group`, 
COUNT(DISTINCT `Employee Number`) AS "Former Employees"
FROM employees
WHERE `Attrition` = 'Yes'
GROUP BY `Age Group`;



/* 12. Total Employees by Marital Status */

SELECT `Marital Status`, 
COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees
GROUP BY `Marital Status`;



/* 13. Current Employees by Marital Status */

SELECT `Marital Status`, 
COUNT(DISTINCT `Employee Number`) AS "Current Employees"
FROM employees
WHERE `Attrition` = 'No'
GROUP BY `Marital Status`;



/* 14. Former Employees by Marital Status */

SELECT `Marital Status`, 
COUNT(DISTINCT `Employee Number`) AS "Former Employees"
FROM employees
WHERE `Attrition` = 'Yes'
GROUP BY `Marital Status`;



/* 15. Total Employees by Education */

SELECT `Education`, 
COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees
GROUP BY `Education`;



/* 16. Current Employees by Education */

SELECT `Education`, 
COUNT(DISTINCT `Employee Number`) AS "Current Employees"
FROM employees
WHERE `Attrition` = 'No'
GROUP BY `Education`;



/* 17. Former Employees by Education */

SELECT `Education`, 
COUNT(DISTINCT `Employee Number`) AS "Former Employees"
FROM employees
WHERE `Attrition` = 'Yes'
GROUP BY `Education`;



/* 18. Total Employees by Education Field */

SELECT `Education Field`, 
COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees
GROUP BY `Education Field`;



/* 19. Current Employees by Education Field */

SELECT `Education Field`, 
COUNT(DISTINCT `Employee Number`) AS "Current Employees"
FROM employees
WHERE `Attrition` = 'No'
GROUP BY `Education Field`;



/* 20. Former Employees by Education Field */

SELECT `Education Field`, 
COUNT(DISTINCT `Employee Number`) AS "Former Employees"
FROM employees
WHERE `Attrition` = 'Yes'
GROUP BY `Education Field`;



/* 21. Total Employees by Job Role */

SELECT `Job Role`, 
COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees
GROUP BY `Job Role`;



/* 22. Current Employees by Job Role */

SELECT `Job Role`, 
COUNT(DISTINCT `Employee Number`) AS "Current Employees"
FROM employees
WHERE `Attrition` = 'No'
GROUP BY `Job Role`;



/* 23. Former Employees by Job Role */

SELECT `Job Role`, 
COUNT(DISTINCT `Employee Number`) AS "Former Employees"
FROM employees
WHERE `Attrition` = 'Yes'
GROUP BY `Job Role`;



/* 24. Total Employees by Department */

SELECT `Department`, 
COUNT(DISTINCT `Employee Number`) AS "Total Employees"
FROM employees
GROUP BY `Department`;



/* 25. Current Employees by Department */

SELECT `Department`, 
COUNT(DISTINCT `Employee Number`) AS "Current Employees"
FROM employees
WHERE `Attrition` = 'No'
GROUP BY `Department`;



/* 26. Former Employees by Department */

SELECT `Department`, 
COUNT(DISTINCT `Employee Number`) AS "Former Employees"
FROM employees
WHERE `Attrition` = 'Yes'
GROUP BY `Department`;
