-- Sorting
-- ORDER BY [ASC/DESC]
--Default

SELECT * FROM customers
ORDER BY first_name ASC;

SELECT * FROM customers
ORDER BY first_name DESC;

-- Multiple columns

SELECT first_name, last_name FROM employees
ORDER BY first_name, last_name DESC; -- for first_name it uses asc order like below

SELECT first_name, last_name FROM employees
ORDER BY first_name ASC, last_name DESC;

SELECT first_name, last_name FROM employees
ORDER BY first_name DESC, last_name DESC;


-------
-- Using Expressions with Order By
-------

SELECT * FROM employees
ORDER BY LENGTH( first_name);

SELECT first_name FROM employees
ORDER BY LENGTH(first_name) DESC;


-- Exercise Order By

/*
* DB: Employees
* Table: employees
* Question: Sort employees by first name ascending and last name descending
*/

SELECT first_name, last_name FROM employees
ORDER BY first_name, last_name DESC;

/*
* DB: Employees
* Table: employees
* Question: Sort employees by age
*/

SELECT AGE(now(), birth_date) 
FROM employees ;

SELECT first_name, last_name, AGE(now(), birth_date) AS age_user
FROM employees ORDER BY age_user DESC;
 
 
--!! 00:37:43 Kernel error: FEHLER:  Spalte »age« existiert nicht
SELECT first_name, last_name, Age FROM employees
ORDER BY AGE(now(), birth_date);

--Sol:
SELECT * FROM employees
ORDER BY birth_date;


/*
* DB: Employees
* Table: employees
* Question: Sort employees who's name starts with a "k" by hire_date
*/

--!! Name validation needed first letter with Capital
SELECT first_name, last_name, hire_date FROM employees
WHERE first_name LIKE 'K%' ORDER BY hire_date;

SELECT first_name, last_name, hire_date FROM employees
WHERE first_name ILIKE 'k%' ORDER BY hire_date;






