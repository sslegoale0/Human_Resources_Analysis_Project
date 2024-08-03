SET sql_safe_updates = 0;

SET sql_mode = "Traditional";

---------------------------------------------------------------------------------------------------------------------------------------------

-- Human Resources Data Cleaning.

CREATE DATABASE human_resources;



-- Imported Human Resources data into MySQL using SQLAlchemy.



USE human_resources;



SELECT *
FROM employees;



DESCRIBE employees;



-- 1. Removal of duplicate rows.

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Id`) AS "Row Number"
FROM employees;

WITH duplicate_employees AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Id`) AS "Row Number"
FROM employees
)
SELECT *
FROM duplicate_employees
WHERE `Row Number` > 1;

-- 2. Data formatting & standardisation.

SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;



SELECT DISTINCT 
FROM calls
ORDER BY ASC;





-- 3. Imputation of null/blank values.




-- 4. Removal of redundant/irrelevant rows.




