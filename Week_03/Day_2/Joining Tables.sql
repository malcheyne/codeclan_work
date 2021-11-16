

/*Task - 5 mins

Prepare for the rest of the lesson by having a look at the 
data in each of the tables in the zoo_pool database (either 
just look at the Data tab for each table, or write and run queries)*/

SELECT *
FROM animals;

SELECT *
FROM animals_tours;
-- This a join table

SELECT *
FROM care_schedule;

SELECT *
FROM diets;

SELECT *
FROM keepers;

SELECT *
FROM tours;


-- INNER JOIN

/* “Get a list of all the animals that have diet plans 
 * together with the diet plans that they are on.”*/

SELECT 
	animals.*,
	diets.*
FROM animals INNER JOIN diets
ON animals.diet_id = diets.id;

/*
  animals INNER JOIN diets tells SQL to join the animals table to the diets table.
  ON animals.diet_id = diets.id tells SQL how to do the join. This says ‘take the rows 
  from animals and the rows from diets and match them by diet_id in animals equalling id in diets’.
  INNER JOIN means ‘return only those rows where there is such a match’.*/

-- We can control the columns returned

-- animals.name is table then column


SELECT 
  animals.name, 
  animals.species, 
  diets.diet_type
FROM animals INNER JOIN diets
ON animals.diet_id = diets.id;

-- and we can also use table aliases to make queries more compact to write

SELECT 
  a.name, 
  a.species, 
  d.diet_type
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id;

-- This only afetes this qurry, unlike R global enviroment

/* Find any known dietary requirements for animals
over four years old*/


-- Good to start with the skeloton then fill out the data 
SELECT 

FROM	INNER JOIN
ON 
WHERE


SELECT 
	a.id,
	a.name,
	a.species,
	a.age,
	d.diet_type
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id
WHERE a.age > 4;

-- "Breakdown the number of animals in the zoo by their diet types.”

SELECT 
  d.diet_type, 
  COUNT(a.id)
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id
GROUP BY d.diet_type;


-- Task
-- “Get the details of all herbivores in the zoo.”

SELECT 
	a.*,
	d.diet_type
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id
WHERE d.diet_type = 'herbivore';


-- LEFT JOIN and RIGHT JOIN

SELECT
	a.*,
	d.*
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id	;

/* There’s no sign of Gerry the Goldfish, or Kim the Kangaroo, 
 * as these animals have NULLs for diet_id. Ditto, tofu is missing 
 * from the table, as no animal has a diet_id of 4 (i.e. no animal prefers tofu).*/

/* “Return the details of all animals in the zoo, together 
 * with their dietary requirements if they have any.”*/

SELECT
	a.*,
	d.*
FROM animals AS a LEFT JOIN diets AS d
ON a.diet_id = d.id	;

-- Task
/* Write and then execute a query to perform a similar RIGHT JOIN. 
 * How do you interpret the results you see? Discuss with the people around you.*/

SELECT
	a.*,
	d.*
FROM animals AS a RIGHT JOIN diets AS d
ON a.diet_id = d.id	;

/* The relationship between the tables is ‘one diets record may be linked to zero, 
 * one or many animals records’. So, when we perform the RIGHT JOIN, we expect that 
 * each diets record will appear at least once in the joined table, and possibly many 
 * times, if multiple animals have that diet. This is why we see tofu, even though 
 * no animal has that diet_type.*/

-- “Return how many animals follow each diet type, including any diets which no animals follow.”
-- Starting with the skeloton
SELECT

	COUNT
FROM animals AS a ? JOIN diets AS d
ON  a.diet_id = d.id
Group BY

SELECT 
  d.diet_type, 
  COUNT(a.id) AS num_animals
FROM animals AS a RIGHT JOIN diets AS d
ON a.diet_id = d.id
GROUP BY d.diet_type;

-- Using RIGHT JOIN or LEFT JOIN by ‘default’

/* Many SQL programmers prefer to stick to always using just one of LEFT JOIN or 
 * RIGHT JOIN by ‘default’ (and they often choose LEFT JOIN). So, they re-arrange 
 * their ‘mental model’ of the relationship between the tables to fit their choice of join.

Let’s re-run the query above as a LEFT JOIN to prove it’s feasible this way too!*/


SELECT 
  d.diet_type, 
  COUNT(a.id) AS num_animals
FROM diets AS d LEFT JOIN animals AS a
ON d.id = a.diet_id
GROUP BY d.diet_type;

-- FULL OUTER JOIN

SELECT 
  a.*, 
  d.*
FROM animals AS a 
FULL OUTER JOIN diets AS d
ON a.diet_id = d.id;


-- Joins in many-to-many relationships

/* “Get a rota for the keepers and the animals they look after, 
 * ordered first by animal name, and then by day.”*/

/* In order to join animals to keepers we have to go in two ‘hops’:

    First, a join from animals to care_schedule
    Second, a join from care_schedule to keepers*/

SELECT


FROM
INNER JOIN
ON
ORDER BY

SELECT
	a.name AS animal_name,
	a.species,
	cs.day,
	k.name AS keeper_name
FROM
	(animals AS a INNER JOIN care_schedule AS cs
	ON a.id = cs.animal_id)
INNER JOIN keepers AS k
ON cs.keeper_id = k.id
ORDER BY a.name, cs.day;

-- Theres two name columns so it's good to change the names by AS

-- Task

/* How would we change the query above to show only the schedule for 
 * the keepers looking after Ernest the Snake?
 * 
Hints

    We need a WHERE clause.
    If we’re limiting the results to those for Ernest the Snake, do we 
    still need to order by animal name?

*/

SELECT
	a.name AS animal_name,
	a.species,
	cs.day,
	k.name AS keeper_name
FROM
	(animals AS a INNER JOIN care_schedule AS cs
	ON a.id = cs.animal_id)
INNER JOIN keepers AS k
ON cs.keeper_id = k.id
WHERE a.name = 'Ernest'
ORDER BY a.name, cs.day;

-- Task

/* Various animals feature on various tours around the zoo (this is another 
 * example of a many-to-many relationship).

    Identify the join table linking the animals and tours table and reacquaint 
    yourself with its contents.
    Obtain a table showing animal name and species, the tour name on which they 
    feature(d), along with the start date and end date (if stored) of their involvement. 
    Order the table by tour name, and then by animal name.
    [Harder] - can you limit the table to just those animals currently featuring on tours. 
    Perhaps the NOW() function might help? Assume an animal with a start date in the past 
    and either no stored end date or an end date in the future is currently active on a tour.
*/

-- Can come back to this

-- Self joins

SELECT *
FROM keepers;

/* “Get a table showing the name of each keeper, together with the name of their 
 * manager (if they have a manager).”*/

SELECT 
	k.name AS employee_name,
	m.name AS manger_name
FROM keepers AS k
LEFT JOIN keepers AS m
ON k.manager_id = m.id;












