
--3 Creating your own functions

--It will be a pain to have to repeatedly type code like

SELECT
...
    100 * (new_val - old_val) / old_val AS percent_change_in_val
...

-- Can create our own function

CREATE OR REPLACE FUNCTION 
percent_change(new_value NUMERIC, 
			old_value NUMERIC, decimals INT DEFAULT 2)
RETURNS NUMERIC AS 
    'SELECT ROUND(100 * (new_value - 
			old_value) / old_value, decimals);'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

/* Beware of creating this function yourselves on omni_pool however! 
 * Functions are ‘owned’ by a particular database user, and behind the 
 * scenes we are all connected to omni_pool as a single user: omni_user. 
 * So we would all end up overwriting each other’s functions! Chaos! 
 * Creating your own function might have to wait until you have your 
 * own distinct username on a future database.*/
 
SELECT
...
    percent_change(new_val, old_val, optional_decimals) AS percent_change_in_val
...

SELECT
    percent_change(107, 98) AS default_decimals,
    percent_change(50, 65, 4) AS four_decimals;
   
 
   
 --4 Investigating query performance via EXPLAIN ANALYZE and INDEXing a column
   
EXPLAIN ANALYZE
SELECT
  department,
    AVG(salary) AS avg_salary
FROM employees 
WHERE country IN ('Germany', 'France', 'Italy', 'Spain')
GROUP BY department
ORDER BY AVG(salary);
   

CREATE INDEX employees_indesed_country ON 
			employees_indexed(country ASC NULLS LAST);
		
-- Can't use as I don't have the permision to change the database
		
		
--	5 Common table expressions (CTEs)
	
--EXPLAIN ANALYZE		
SELECT *
FROM employees
WHERE country = 'United States' AND fte_hours IN (
  SELECT fte_hours
  FROM employees
  GROUP BY fte_hours
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      SELECT COUNT(*) AS count
      FROM employees
      GROUP BY fte_hours
    ) AS temp
  )
);
		
/*This works, but we think you’ll agree that it’s really horrible to read, and it’s actually 
 * somewhat inefficient, as you can see we GROUP BY fte_hours twice! Let’s see how we could tidy 
 * this up using CTEs!

    Think about what each subquery does. In this case, there is one repeating ‘theme’ in the 
    subqueries: calculate the number of employees working each fte_hours pattern.
    
    So we can write a ‘central’ subquery that provides just this table of counts, and then two 
    other subqueries that use the counts. Rather than subqueries, however, we will code these as 
    CTEs: temporary tables defined at the start of a query that exist only while the query is running.
    
    We create CTEs using WITH and AS commands, and for this reason, queries that use CTEs are often called 
    ‘WITH queries’.
    
    Finally we write the subsequent query making use of any or all of the CTEs we’ve defined*/

--EXPLAIN ANALYZE
WITH fte_count AS (
    SELECT
        fte_hours,
        COUNT(*) AS count
    FROM employees
    GROUP BY fte_hours
),
max_fte_count AS (
    SELECT 
        MAX(count) AS max_count
    FROM fte_count
),
most_common_fte AS (
    SELECT
        fte_hours
    FROM fte_count 
    WHERE count = (
        SELECT 
          max_count 
        FROM max_fte_count
    )
)
SELECT *
FROM employees
WHERE country = 'United States' AND fte_hours IN (
    SELECT
        fte_hours 
    FROM most_common_fte
);

--6 Window functions

SELECT
  first_name,
  last_name,
  department,
  salary,
  MIN(salary) OVER (PARTITION BY department) as min_sal_dept,
  MAX(salary) OVER (PARTITION BY department) as max_sal_dept
FROM employees
ORDER BY id;






