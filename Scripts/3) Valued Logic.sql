-- Three-Valued Logic
-- besides true and false the result of logical expressions can also be unknown
-- TRUE , NULL, FALSE

1 = 1; -- true
NULL = 1; -- NULL

(NULL = 1) OR (1=1) ;  --TRUE
(NULL = 1) AND (1=1) ; --NULL  not false

SELECT <COLUMN> FROM <TABLE> WHERE <COLUMN> = NULL; -- All result will be NULL
SELECT <COLUMN> FROM <TABLE> WHERE <COLUMN> IS NULL; -- Null values will be TRUE

--

SELECT <COLUMN> FROM <TABLE> WHERE (<COLUMN> = NULL) OR (NOT <COLUMN> = NULL); -- no result
SELECT <COLUMN> FROM <TABLE> WHERE (<COLUMN> IS NULL) OR (<COLUMN> IS NOT NULL); -- all dataset will be returned

--Exercises
/*
* DB: Store
* Table: customers
* Question: adjust the following query to display the null values as "No Address"
*/
SELECT address2 
FROM customers

/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/

SELECT *
FROM customers
WHERE COALESCE(address2, NULL) IS NOT NULL;

/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/

SELECT COALESCE(lastName, 'Empty'), * FROM customers
WHERE (age = NULL);
