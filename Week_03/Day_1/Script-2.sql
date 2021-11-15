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

