

-- “Find the number of employees within each department of the corporation.”


SELECT 
  COUNT(id) AS number_employees 
FROM employees 
WHERE department = 'Legal';


-- (there must be a better way ;P)

SELECT 
  department, 
  COUNT(id) AS num_employees 
FROM employees 
GROUP BY department;

-- “How many employees are there in each country?”

SELECT 
  country, 
  COUNT(id) AS num_employees 
FROM employees 
GROUP BY country;

-- Combination with WHERE
-- “How many employees in each department work either 0.25 or 0.5 FTE hours?”

SELECT 
  department, 
  COUNT(id) AS num_fte_quarter_half 
FROM employees 
WHERE fte_hours BETWEEN 0.25 AND 0.5 
GROUP BY department;

-- DIFFERENT COUNTS

SELECT 
  COUNT(first_name) AS count_first_name,
  COUNT(id) AS count_id,
  COUNT(*) AS count_star
FROM employees;

/*The difference in counts arises because there are NULL 
entries in the first_name column, and COUNT() skips NULLs. 
Generally speaking, if you want a count of rows, stick to using 
COUNT(*) or COUNT() of a primary key (which cannot be NULL by 
definition), e.g. COUNT(id) in this case.*/

--WHERE before GROUP BY
-- Order of how to write 
-- (S)o (F)ew (W)orkers (G)o (H)ome (O)n time
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT

-- It Runs them in this order


-- “Find the longest time served by any one employee in each department.”

-- Note as we're using NOW the date is diffrent from the one in the class notes 

SELECT 
  department, 
  NOW()-MIN(start_date) AS longest_time
FROM employees 
GROUP BY department;

/* This has give it in days, we want in years*/

SELECT 
  department, 
  EXTRACT(DAY FROM NOW()-MIN(start_date)) AS longest_time_days,
  ROUND(EXTRACT(DAY FROM NOW()-MIN(start_date))/365) AS longest_time_approx_years
FROM employees 
GROUP BY department;

-- How does group by group by?

-- Sorts data into groups
-- labels them 

-- Task

-- 1. “How many employees in each department are enrolled in the pension scheme?”


SELECT 
	department,
	COUNT(*) AS num_enrolled
FROM employees
WHERE pension_enrol IS TRUE
GROUP BY department;


/* Jonny's work*/

SELECT
	department,
	COUNT(pension_enrol = TRUE) AS employees_enrolled_on_pension,
	COUNT(pension_enrol)
FROM employees
-- WHERE pension_enrol = TRUE
GROUP BY department;

/* The count is not taking the TRUE argument in the () so is just counting the all 
 * the numbers in pension_enrol that's not NULL, best to used row filtering in the WHERE 
 */

-- 2. “Perform a breakdown by country of the number of employees that do not have a stored first name.” 

SELECT
	country,
	COUNT(*) AS num_name_missing
FROM employees
WHERE first_name IS NULL
GROUP BY country;


-- HAVING

-- WHERE clause lets us filter rows
-- HAVING clause lets us filter groups

-- “Show those departments in which at least 40 employees work either 0.25 or 0.5 FTE hours”


SELECT 
	department,
	COUNT (id) AS num_fte_quarter_half
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5
GROUP BY department
HAVING COUNT(id) >= 40;

/*We’ve added a HAVING clause after the GROUP BY: notice that it filters using an 
 * aggregate function applied to a column of the original table.
 * How we write SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT
 * How SQL opperates FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY, LIMIT
 */

/*“Show any countries in which the minimum salary amongst pension 
 * enrolled employees is less than 21,000 dollars.”
 */

SELECT 
  country, 
  MIN(salary) as min_salary 
FROM employees 
WHERE pension_enrol = TRUE 
GROUP BY country 
HAVING MIN(salary) < 21000;

-- Task

-- “Show any departments in which the earliest start date amongst grade 1 employees is prior to 1991”

SELECT
	department,
	grade,
	start_date,
	MIN(start_date)
FROM employees 
WHERE grade = 1
GROUP BY department
HAVING MIN(start_date) IS <= 1991-01-01;

-- Class work out of my work

SELECT
	department,
	grade,
	start_date,
	MIN(start_date)
FROM employees 
WHERE grade = 1
GROUP BY department
HAVING MIN(start_date)  <= 1991-01-01;

/*SQL Error [42883]: ERROR: operator does not exist: date <= integer
  Hint: No operator matches the given name and argument types. You might need to add explicit type casts.
  Position: 143*/

SELECT
	department,
	grade,
	start_date,
	MIN(start_date)
FROM employees 
WHERE grade = 1
GROUP BY department
HAVING MIN(start_date)  <= '1991-01-01';

/* SQL Error [42803]: ERROR: column "employees.grade" must appear in the GROUP BY clause or be used in an aggregate function
  Position: 24*/

/* It's not sure what to do  with grade and start_date, ie there's more than one what do you want me to do,
 * aggregate them into one number or take them out*/

SELECT
	department,
	MAX(grade),
	MIN(start_date)
FROM employees 
WHERE grade = 1
GROUP BY department
HAVING MIN(start_date)  <= '1991-01-01';


-- Subqueries

--  “Find all the employees in Japan who earn over the company-wide average salary.”


-- find the company wide avg salary, then use the value to filter

SELECT *
FROM employees
WHERE country = 'Japan' AND salary > AVG(salary);

-- SQL Error [42803]: ERROR: aggregate functions are not allowed in WHERE Position: 64

-- (oh on) we can't perform aggregate functions in a WHERE clause

SELECT AVG(salary)
FROM employees;


SELECT *
FROM employees
WHERE country = 'Japan' AND 
	salary > (SELECT AVG(salary) FROM employees);

-- Task

-- “Find all the employees in Legal who earn less than the mean salary in that same department.”

SELECT *
FROM employees
WHERE department = 'Legal' AND salary < (
	SELECT AVG(salary) 
	FROM employees
	WHERE department = 'Legal'
	);


-- Task

-- “Find all the employees in the United States who work the most 
-- common full-time equivalent hours across the corporation.”





SELECT *
FROM employees
WHERE country = 'United States' AND fte_hours = (
	SELECT fte_hours
	FROM employees
	GROUP BY fte_hours
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

-- Same as above

SELECT *
FROM employees
WHERE country = 'United States' AND fte_hours = 0.75;

-- subquery to calculate the mode:

SELECT fte_hours,
COUNT(id) AS num_on_shift
FROM employees
GROUP BY fte_hours
ORDER BY COUNT(*)DESC
LIMIT 4;

-- For our querry, all we want is the most common fte hours


SELECT fte_hours
FROM employees
GROUP BY fte_hours
ORDER BY COUNT(*)DESC
LIMIT 1;

-- Feed that back in to, good to write out in long hand then feed it back in
