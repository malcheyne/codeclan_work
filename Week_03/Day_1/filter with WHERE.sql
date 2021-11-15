-- Filter by WHERE
-- AND and OR
-- BETWEEN, NOT and IN
-- LIKE and wildcards
-- IS NULL


SELECT *
FROM employees;

-- Find the employee with id = 3

SELECT *
FROM employees
WHERE id = 3;

-- Find all the employees working 0.5 full time
-- equivalent hours or greater.

-- != : not equal
-- >  : greater than
-- <  : less than
-- >= : greater than or equal to
-- <= : less than or equal to

SELECT *
FROM employees
WHERE fte_hours >= 0.5;

-- Find all the employees not based in Brazil.

SELECT *
FROM employees
WHERE country != 'Brazil';

-- Have to uses '' not bunny ""

/* use  to start a commint 
 * will make it a cross more than 1 line
 */

/* Find all employees in China who 
 * started working for OmniCorp in 2019.
 * 
 */

SELECT *
FROM employees
WHERE country = 'China' AND start_date >= '2019-01-01' AND start_date <= '2019-12-31';

/*Of all the employees based in China, 
 * find those who either started working 
 * for OmniCorp from 2019 onwards or who 
 * are enrolled in the pension scheme.
 */

SELECT * 
FROM employees 
WHERE country = 'China' AND 
start_date >= '2019-01-01' OR 
pension_enrol = TRUE;

/* You don't have to keep the rows sort like R 
 * but still works and reads better. Use enter
 * after someting to show it's gose to the row 
 * below
 */

SELECT * 
FROM employees 
WHERE country = 'China' AND 
(start_date >= '2019-01-01' OR 
pension_enrol = TRUE);

/* Find all employees who work between 0.25 and 0.5 
 * full-time equivalent hours inclusive.
 */

SELECT *
FROM employees
WHERE fte_hours >= 0.25 AND fte_hours <= 0.5;

/*Find all employees who started working for 
 * OmniCorp in years other than 2017. 
 */

SELECT * 
FROM employees 
WHERE start_date < '2017-01-01' OR start_date > '2017-12-31';

-- BETWEEN, NOT and IN

SELECT *
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5;

-- Same as two above

SELECT * 
FROM employees 
WHERE start_date NOT BETWEEN '2017-01-01' AND '2017-12-31';

-- Same as two above

-- Task
/* Find all employees who started work at OmniCorp 
 * in 2016 who work 0.5 full time equivalent hours or greater.
 */

SELECT *
FROM employees
WHERE start_date >= '2016-01-01' AND 
fte_hours >= 0.5;

-- Johny work just looked at 2016 only
SELECT *
FROM employees 
WHERE (start_date BETWEEN '2016-01-01' AND '2016-12-31') AND fte_hours >= 0.5;

/*Find all employees based in Spain, South Africa, 
 * Ireland or Germany.
 */

SELECT * 
FROM employees 
WHERE country = 'Spain' OR country = 'South Africa' OR 
country = 'Ireland' OR country = 'Germany';

-- Alternative

SELECT * 
FROM employees 
WHERE country IN ('Spain', 'South Africa', 'Ireland', 'Germany');


/*Find all employees based in countries other than Finland, 
 * Argentina or Canada.
 */

-- NOT IN LIKE !=

SELECT * 
FROM employees 
WHERE country NOT IN ('Finland', 'Argentina', 'Canada');

-- SELECT : Colunm wise
-- FROM	  : Table
-- WHERE  : Filter by rows

-- AND and OR, BETWWEN, NOT IN

-- LIKE (regex)
-- IS NULL


/*I was talking with a colleague from Greece last month, 
 * I can’t remember their last name exactly, I think it 
 * began ‘Mc…’ something-or-other. Can you find them?
 */

SELECT * 
FROM employees 
WHERE country = 'Greece' AND last_name LIKE 'Mc%';

/*The string after LIKE is called a pattern, so in this case, the pattern is 'Mc%'
 * Here are the wildcards we can use in a pattern:
 * Have to use after LIKE
 */

-- _ : a single character
-- % : zero or more characters

/* Find all employees with last names containing the phrase ‘ere’ anywhere.
 * 
 */

SELECT * 
FROM employees 
WHERE last_name LIKE '%ere%';

/* Find all employees in the Legal department with a last name beginning with ‘D’.
 * 
 */

SELECT * 
FROM employees 
WHERE department = 'Legal' AND last_name LIKE 'D%';

/* Task
 * Find all employees having ‘a’ as the second letter of their first names.
 */

SELECT *
FROM employees
WHERE first_name LIKE '_a%';

SELECT *
FROM employees
WHERE first_name LIKE '__a%';

/* Having 2 _ '__a%' now finds the 3rd letter
 * 
 */

/*Find all employees whose last name contains the 
 * letters ‘ha’ anywhere.
 */

SELECT * 
FROM employees 
WHERE last_name ILIKE '%ha%';

/* LIKE distinguishes between capital and lower case 
 * letters. If we need a case-insensitive version, 
 * we can use ILIKE
 */

/* POSIX comparators (POSIX is a standard that tries to 
 * ensure consistency across various operating systems)
 */

-- : ~   case-sensitive matches
-- : ~*  case-insensitive matches
-- : !~  case-sensitive does not match
-- : !~* case-insensitive does not match


/* Find all employees for whom the second letter of their last
 * name is ‘r’ or ‘s’, and the third letter is ‘a’ or ‘o’.
 */

SELECT * 
FROM employees 
WHERE last_name ~ '^.[rs][ao]';

-- starts with "^"
-- any char "."
-- next char (2) is "r" or "s"
-- next char (3) is "a" or "o"

-- while here is the negation of the same query:

SELECT * 
FROM employees 
WHERE last_name !~* '^.[rs][ao]';


-- IS NULL

/* We need to ensure our employee records are up-to-date. 
 * Find all the employees who do not have a listed email address.
 */

SELECT * 
FROM employees 
WHERE email IS NULL;


SELECT * 
FROM employees 
WHERE email IS NOT NULL;

-- Recap

-- In summary, here are the different keyword components of a SELECT query, the order in which they must appear, and whether they are required or optional

/*This table shows where we got to in this lesson:
 * Order 	Keyword 	Specifies 			Required?
 * 1 		SELECT 		Column to query 	Yes
 * 2 		FROM 		Table to query 		Yes
 * 3 		WHERE 		Row-level filter 	No
 */

-- and here’s a look at what’s still to come:

/* Order 	Keyword 	Specifies 					Required?
 * 5 		GROUP BY 	Grouping for aggregates 	No
 * 6 		HAVING 		Group-level filter 			No
 * 7 		ORDER BY 	Sort order 					No
 * 8 		LIMIT 		How many records to return 	No
 */







