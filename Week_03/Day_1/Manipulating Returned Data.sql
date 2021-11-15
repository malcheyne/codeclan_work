

/*  Learing Objectives
 *  Be able to create column aliases using AS
 *  Use DISTINCT to return unique records by column
 *  Understand and be able to use aggregate functions
 *  Be able to sort records and limit the number returned
*/

SELECT 
  id, 
  first_name, 
  last_name 
FROM employees 
WHERE department = 'Accounting';

-- Same as 

SELECT id, first_name, last_name 
FROM employees 
WHERE department = 'Accounting';
    
 SELECT 
 	id, 
 	first_name, 
 	last_name, 
 	department 
FROM employees 
WHERE department = 'Accounting';   
    
-- Aliases via AS

/* Can we get a list of all employees with 
 * their first and last names combined together 
 * into one field called ‘full_name’?
 */

-- CONCAT() 

/* concatenate (this is just a fancy way of saying 
 * ‘join strings together’) each pair of names into the full name. 
 */

SELECT
  CONCAT('Hello', ' ', 'there!') AS greeting;

-- || is the same as CONCAT()
 
 SELECT
  'Hello' || ' ' || 'there!' AS greeting;
 
 
 
 SELECT 
  id, 
  first_name, 
  last_name, 
  CONCAT(first_name, ' ', last_name) AS full_name 
FROM employees;
 
 /* Task
  * Add a WHERE clause to the query above to filter out 
  * any rows that don’t have both a first and second name.
  */
 
 SELECT 
  id, 
  first_name, 
  last_name, 
  CONCAT(first_name, ' ', last_name) AS full_name 
FROM employees
WHERE first_name IS NOT NULL AND last_name IS NOT NULL;

-- DISTINCT()

/* Our database may be out of date! After the recent restructuring, 
 * we should now have six departments in the corporation. How many 
 * departments do employees belong to at present in the database?
 */

SELECT 
  DISTINCT(department) 
FROM employees;

-- Aggregate functions

-- COUNT()
-- SUM()
-- AVG()
-- MIN()
-- MAX()

/*
 * How many employees started work for the corporation in 2001?
 */

SELECT 
  COUNT(*) AS total_employ_2001
FROM employees 
WHERE start_date BETWEEN '2001-01-01' AND '2001-12-31';


/* Task
 * 1. “What are the maximum and minimum salaries of all employees?”
 * 2. “What is the average salary of employees in the Human Resources department?”
 * 3. “How much does the corporation spend on the salaries of employees hired in 2018?”
 */

SELECT
	MAX(salary) AS max_salary
FROM employees;

SELECT
	MIN(salary) AS min_salary
FROM employees;

-- Can do in the same function

SELECT
	MAX(salary) AS max_salary,
	MIN(salary) AS min_salary
FROM employees;

SELECT
	AVG(salary) AS avg_HR_salary
FROM employees
WHERE department = 'Human Resources';

SELECT
	SUM(salary) AS total_salary
FROM employees
WHERE start_date BETWEEN '2018-01-01' AND '2018-12-31';


-- if you have table you have to call it plorals ie sheeps not sheep

-- Sort by Columns
--  ORDER BY always comes after any WHERE clause

SELECT * 
FROM employees 
WHERE salary IS NOT NULL 
ORDER BY salary ASC 
LIMIT 1;

-- Descending order, Nulls last
SELECT * 
FROM employees 
WHERE salary IS NOT NULL 
ORDER BY salary DESC NULLS LAST;

-- Aescending order, Nulls last
SELECT * 
FROM employees 
WHERE salary IS NOT NULL
ORDER BY salary ASC NULLS LAST; 

/* Order employees by full-time equivalent hours, 
 * highest first, and then alphabetically by last name.
 */

SELECT * 
FROM employees 
ORDER BY 
  fte_hours DESC NULLS LAST, 
  last_name ASC NULLS LAST;

-- hours frist, then last name 

/* Task
 * 1. Get the details of the longest-serving employee of the corporation.
 * 2. Get the details of the highest paid employee of the corporation in Libya.
 */
 
 SELECT *
 FROM employees
 ORDER BY
 	start_date ASC NULLS LAST
 LIMIT 1;
 
 
 SELECT *
 FROM  employees
 WHERE country = 'Libya'
 ORDER BY
 	salary ASC NULLS LAST
 LIMIT 1;
 

/*
 
A note on ties

Be careful when you’re trying to find rows that have the maximum or minimum in a 
particular column in situations where ties are likely (i.e. more than one row has the 
maximum or minimum value). In this case using LIMIT 1 will just arbitrarily select one 
of the tied rows, while you would usually rather see all tied rows.

A better approach in this case would involve two queries:

    Write a first query to find the maximum or minimum value in a column as required
    Use this maximum or minimum value in the WHERE clause of a second query to find all rows with that value

We’ll cover the concept of subqueries tomorrow, which will let us combine these ‘two queries’ into a single query.

*/

-- Recap

/*
 Order of definition 	Keyword 	Specifies 					Required?
			1 			SELECT 		Column to query 			Yes
			2 			AS 			Column alias 				No
			3 			FROM 		Table to query 				Yes
			5 			GROUP BY 	Grouping for aggregates 	No
			6 			HAVING 		Group-level filter 			No
			7 			ORDER BY 	Sort order 					No
			8 			LIMIT 		How many records to return 	No
 */





