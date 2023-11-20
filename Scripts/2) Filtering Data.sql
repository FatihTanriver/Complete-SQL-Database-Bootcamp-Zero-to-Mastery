/*
*AND
*OR
*NOT
*Comparison Operators
*Logical Operators
*IN
*DISTINCT
*/

--Get All Female Employees (DB: employees);
SELECT * FROM employees WHERE gender = 'F';


/*
*DB: Store
*How Many Female Customers do we have from the
* state of Oregon (O) and New york (NY)
*/

SELECT firstname, lastname, state, gender FROM customers WHERE gender = 'F' AND (state = 'OR' OR state = 'NY');

SELECT firstname, lastname, state, gender FROM customers WHERE gender = 'F' AND state IN ('OR', 'NY');

--NOT
--Non male customers

SELECT firstname, gender FROM customers WHERE NOT gender = 'M';

-- How Many Customers aren't 55(DB: Store)

SELECT firstname, lastname, age FROM customers WHERE NOT age = 55;

--------------Comparison Operators------------------------------------------------------------------------
--Comparison Operators 
-- Who over the age of 44 and has an income of 100 000?
SELECT * FROM employees WHERE age > 44;

--How many female customers do we have from the state of Oregon (OR)?
SELECT Count(*) FROM customers WHERE gender = 'F' AND state = 'OR';

--Who over the age of 44 has an income of 100 000 or more?
SELECT firstname, lastname FROM customers WHERE age > 44 AND income >= 100000;

--Who between the ages of 30 and 50 has an income of less than 50 000?
SELECT firstname, lastname FROM customers WHERE age >= 30 AND age <=50  AND income < 50000;

--What is the average income between the ages of 20 and 50?
SELECT AVG(income) FROM customers WHERE age > 20 AND age <50

--------------Logical Operators------------------------------------------------------------------------

FROM -> WHERE -> SELECT

--Operator Precedence--------------

--Select people either under 30 or over 50 with an income above 50000 that are from either Japan or Australia
SELECT * FROM  Customers;

SELECT DISTINCT(Country) FROM Customers;

SELECT firstname, lastname, age, country, income
FROM customers
WHERE (age < 30 OR age > 50) AND income > 50000 AND (country = 'Australia' OR country = 'Japan');

/*
* DB: Store
* Table: Customers
* Question: 
* Select people either under 30 or over 50 with an income above 50000
* Include people that are 50
* that are from either Japan or Australia
*/

SELECT firstname, lastname, age, country, income
FROM customers
WHERE (age < 30 OR age >= 50) AND income > 50000 AND (country = 'Australia' OR country = 'Japan');

/*
* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?
*/
    SELECT Sum(totalamount) 
    FROM Orders 
    WHERE orderdate > '2004-05-31' 
          AND orderdate < '2004-07-01' 
          AND totalamount > 100;

--or this solution
    SELECT SUM(totalamount) FROM orders
    WHERE (orderdate >= '2004-06-01' AND orderdate <= '2004-06-30') 
    AND totalamount > 100


-- IN keyword
-- check a  value exist in a filter

/*
* DB: Store
* Table: orders
* Question: How many orders were made by customer 7888, 1082, 12808, 9623
*/

SELECT COUNT(*) FROM orders WHERE customerid IN (7888, 1082, 12808, 9623);


/*
* DB: World
* Table: city
* Question: How many cities are in the district of Zuid-Holland, Noord-Brabant and Utrecht?
*/

SELECT COUNT (*) FROM city WHERE district IN('Zuid-Holland', 'Noord-Brabant', 'Utrecht');



----- Like
--Partial Lookups, Patterns match
-- POSTGres support 'Like' for Text Comparison
    -- CAST(salary AS text);
    -- salary::text  
    
  --!! 'ILIKE' for case insensitive; 
  -- name ILIKE 'MO%';   

/*
* Wildcards:
*   % Any number of characters  
*   - 1 character
*/

-- Starts with 'M'
SELECT first_name FROM employees WHERE first_name LIKE 'M%';

-- End with 'M'
SELECT first_name FROM employees WHERE first_name LIKE '%M';

-- Contains 'M'
SELECT first_name FROM employees WHERE first_name LIKE '%M%';

-- First any character  , second 'M' third 'K' than rest can be anything
SELECT first_name FROM  WHERE first_name LIKE '_MK%';

-- LIKE '2_%_%'     -- Find any values that starts with 2 and at least 3 character

-- Starts with 'M' 3(_) : At least 4 character
SELECT first_name FROM employees WHERE first_name LIKE 'M___';


/*
* EXERCISES - 'LIKE'
*/

/*
* DB: Employees
* Table: employees
* Question: Find the age of all employees who's name starts with M.
* Sample output: https://imgur.com/vXs4093
* Use EXTRACT (YEAR FROM AGE(birth_date)) we will learn about this in later parts of the course
*/
SELECT ..., EXTRACT (YEAR FROM AGE(birth_date)) AS "age" FROM employees;


SELECT emp_no, first_name, EXTRACT (YEAR FROM AGE(birth_date)) AS "age" FROM employees
WHERE first_name ILIKE 'M%';


/*
* DB: Employees
* Table: employees
* Question: How many people's name start with A and end with R?
* Expected output: 1846
*/

SELECT Count(*) FROM employees WHERE first_name LIKE 'A%' AND first_name ILIKE '%R' ;

SELECT count(emp_no) FROM employees
WHERE first_name ILIKE 'A%R';
                                                  
/*
* DB: Store
* Table: customers
* Question: How many people's zipcode have a 2 in it?.
* Expected output: 4211 
*/

-- Need casting to text
SELECT Count (*) FROM customers WHERE zip::TEXT LIKE '%2%';


/*
* DB: Store
* Table: customers
* Question: How many people's zipcode start with 2 with the 3rd character being a 1.
* Expected output: 109 
*/

SELECT Count (*) FROM customers WHERE zip::TEXT LIKE '2_1%';

/*
* DB: Store
* Table: customers
* Question: Which states have phone numbers starting with 302?
* Replace null values with "No State"                                                  
* Expected output: https://imgur.com/AVe6G4c
*/

SELECT firstname, lastname, COALESCE(state, 'No State'), phone FROM customers WHERE phone::TEXT LIKE '302%';


/*
*   DISTINCT
*/

-- Remove Duplicates

-- will work for one column and more columns

SELECT DISTINCT Salary FROM salaries; --

SELECT DISTINCT Salary, Age FROM salaries; --

/*
* DB: Employees
* Table: titles
* Question: What unique titles do we have?
*/

SELECT DISTINCT title FROM titles; -- Brings distinct titles
SELECT Count(DISTINCT title) FROM titles;  -- # of distinct titles


/*
* DB: Employees
* Table: employees
* Question: How many unique birth dates are there?
*/

SELECT DISTINCT(birth_date) FROM employees;
SELECT Count(DISTINCT(birth_date)) FROM employees; -- 4750

/*
* DB: World
* Table: country
* Question: Can I get a list of distinct life expectancy ages
* Make sure there are no nulls
*/

SELECT DISTINCT(lifeexpectancy) FROM country WHERE lifeexpectancy IS NOT NULL;
--with null 161
--without null 160

SELECT DISTINCT lifeexpectancy FROM country
WHERE lifeexpectancy IS NOT NULL
ORDER BY lifeexpectancy;




