--Aggreagate Functions
--*runs against all data produce 1 value
--*take all data and gives one output i.E SUM

--Number of all employees
SELECT Count(*) FROM  employees; 

SELECT Count(emp_no) FROM employees;

--Get the highest salary available 
SELECT Max(salary) FROM salaries;

--Get the total amount of salaries paid
SELECT Sum(salary) FROM salaries;

-- Question 1: What is the average salary for the company? (DB: Employees.Salaries)
SELECT AVG(salary) FROM salaries;

-- Question 2: What year was the youngest person born in the company?
--SELECT birth_date  FROM employees Order BY birth_date DESC;
SELECT MAX(birth_date)  FROM employees ;

-- Question 1: How many towns are there in france? DB:FRANCE
SELECT Count(*) FROM towns;
SELECT Count(id) FROM towns;


-- Question 1: How many official languages are there? DB:World
SELECT Count(*) FROM countrylanguage WHERE isofficial = TRUE;


-- Question 2: What is the average life expectancy in the world? DB:World
SELECT AVG(lifeexpectancy) FROM country;

-- Question 3: What is the average population for cities in the netherlands? DB:World

SELECT AVG(population) FROM city WHERE countrycode = 'NLD';
SELECT AVG(population) FROM city WHERE countrycode = (SELECT code FROM country WHERE NAME = 'Netherlands');



