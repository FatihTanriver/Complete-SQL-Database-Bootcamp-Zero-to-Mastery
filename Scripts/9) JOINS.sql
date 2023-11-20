--JOINS


-------
-- MULTI Table Select
-------

SELECT count(*) FROM employees; --300024
SELECT count(*) FROM salaries;  --2844047

SELECT  a.emp_no, 
        --CONCAT(a.first_name, a.last_name) AS "name",
        b.salary
FROM employees AS a, salaries AS b
WHERE a.emp_no = b.emp_no ORDER BY a.emp_no;





-------
-- INNER JOIN
-------

-- intersection
-- inner join is best queries
-- ON keyword work same as WHERE

--Bring employees with salaries
SELECT  a.emp_no, 
        b.salary
FROM employees AS a
INNER JOIN salaries AS b ON b.emp_no = a.emp_no;
ORDER BY a.emp_no ASC;

-- Bring the employees salaries with title change
SELECT  a.emp_no,
        CONCAT(a.first_name,' ' ,a.last_name) AS "fullname",
        b.salary,
        c.title,
        c.from_date AS "promoted on"
FROM employees AS a
INNER JOIN salaries AS b ON b.emp_no = a.emp_no
INNER JOIN titles AS c ON c.emp_no = a.emp_no AND
                          c.from_date = (b.from_date + INTERVAL '2 days') -- title changes 2 days later after the promotion
ORDER BY a.emp_no ASC;


-- Bring the employees salaries with
-- Before and after title change  or original salary(when no title change)
SELECT  a.emp_no,
        CONCAT(a.first_name,' ' ,a.last_name) AS "fullname",
        b.salary,
        c.title,
        c.from_date AS "promoted on"
FROM employees AS a
INNER JOIN salaries AS b ON b.emp_no = a.emp_no
INNER JOIN titles AS c ON   c.emp_no = a.emp_no 
                            AND (c.from_date = (b.from_date + INTERVAL '2 days') 
                            OR b.from_date = c.from_date) 
ORDER BY a.emp_no ASC;


-------
-- SELF JOIN
-------
--! joining a table itself
--! this usually can be done when a table has a FOREIGN key referncing its PRIMARY key

-- id -name - startDate- supervisorid

CREATE TABLE employees(
id VARCHAR(5) NOT NULL,
fname VARCHAR(20) NULL,
start_date date NULL,
supervisorId VARCHAR(5) NULL,
CONSTRAINT id PRIMARY KEY(id),
CONSTRAINT supervisorId FOREIGN KEY(supervisorId)
REFERENCES employees(id));

INSERT INTO employees VALUES ('1', 'Big Boss', date '1980/01/23','1');
INSERT INTO employees VALUES ('2', 'Boss', date '1980/01/23','1');
INSERT INTO employees VALUES ('2', 'John', date '1980/01/23','2');



SELECT a.id, a.name AS "employee", b.name AS "supervisor name"
FROM employees AS a, employees AS b
WHERE a.supervisorId = b.id;

SELECT a.id, a.name AS "employee", b.name AS "supervisor name"
FROM employees AS a
INNER JOIN employees AS b
ON a.supervisorId = b.id;

-- db Fiddle : https://www.db-fiddle.com/f/bD5U4FAEM52VBYvumm8fNQ/1


-------
-- OUTER JOIN
--      LEFT OUTER JOIN
--      RIGHT OUTER JOIN
-------
--? what if i also need the rows that don't match?
-- OUTER Joins add the data that don't have a MATCH
-- Left Joins  Table A
-- Right Joins  Table B

    --Left Outer Join
    SELECT emp.emp_no AS "emp_no", dep.emp_no AS "dep_no"
    FROM employees AS emp
    LEFT OUTER JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no;

    --Those who are manager 
    SELECT emp.emp_no AS "emp_no", dep.emp_no AS "dep_no"
    FROM employees AS emp
    LEFT OUTER JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no
    WHERE dep.emp_no IS NOT NULL ;

    SELECT emp.emp_no AS "emp_no", dep.emp_no AS "dep_no"
    FROM employees AS emp
    INNER JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no;

    --Those who aren't manager
    SELECT Count(emp.emp_no) 
    FROM employees AS emp
    LEFT OUTER JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no
    WHERE dep.emp_no IS NULL ;


    -- Every Salary Raise and also know which one is promotions
 
 --Original Query:   
    SELECT  a.emp_no,
        CONCAT(a.first_name,' ' ,a.last_name) AS "fullname",
        b.salary,
        c.title,
        c.from_date AS "promoted on"
    FROM employees AS a
    INNER JOIN salaries AS b ON b.emp_no = a.emp_no
    INNER JOIN titles AS c ON   c.emp_no = a.emp_no 
                                AND (c.from_date = (b.from_date + INTERVAL '2 days') 
                                OR b.from_date = c.from_date) 
    ORDER BY a.emp_no ASC;


    --
    SELECT  a.emp_no,
        CONCAT(a.first_name,' ' ,a.last_name) AS "fullname",
        b.salary,
        c.title,
        c.from_date AS "promoted on"
        FROM employees AS a
        INNER JOIN salaries AS b ON b.emp_no = a.emp_no
        LEFT JOIN titles AS c ON   c.emp_no = a.emp_no 
                                    AND (c.from_date = (b.from_date + INTERVAL '2 days') 
                                    OR b.from_date = c.from_date) 
        ORDER BY a.emp_no ASC;

 /*   SELECT  a.emp_no,
        CONCAT(a.first_name,' ' ,a.last_name) AS "fullname",
        b.salary,
        c.title,
        c.from_date AS "promoted on"
        FROM employees AS a
        INNER JOIN salaries AS b ON b.emp_no = a.emp_no
        INNER JOIN titles AS c ON   c.emp_no = a.emp_no 
     ORDER BY a.emp_no ASC;
 */
-------
-- Less Common JOINs
-------

--* CROSS JOIN
	--cartesian product
	https://www.db-fiddle.com/f/jRh57av4b8i8kQUChpBKSN/0
	
--* FULL OUTER JOIN
-- return results from both whether they match or not
	https://www.db-fiddle.com/f/dAb6mjWqWay6ECY1o2v478/1

-------
-- INNER JOIN Exercises
-------

/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/


Select o.orderid, o.customerid, c.customerid, c.firstname, c.lastname, c.state
From Orders as o 
Inner Join Customers c ON o.customerid = c.customerid
Where c.state IN ('OH','NY','OR')
Order By o.orderid;
 

/*
* DB: Store
* Table: products
* Question: Show me the inventory for each product
*/


Select pr.title, pr.actor, inv.quan_in_stock, inv.sales
From products as pr
INNER join Inventory as inv ON pr.prod_id = inv.prod_id;


/*
* DB: Employees
* Table: employees
* Question: Show me for each employee which department they work in
*/

SELECT a.emp_no, a.first_name, a.last_name, c.dept_name
FROM employees as a
INNER Join dept_emp AS b On a.emp_no = b.emp_no
INNER JOIN departments AS c ON b.dept_no = c.dept_no;


Select Count(Distinct(emp_no)) FROM dept_emp; == Select Count(*) From employees;




-----
--Using
-----

-- when matching keys are identical i.e emp_no


SELECT e.emp_no, e.first_name, de.dept_no
FROM employees as e
INNER Join dept_emp AS de On e.emp_no = de.emp_no;



SELECT e.emp_no, e.first_name, de.dept_no
FROM employees as e
INNER Join dept_emp AS de USING(emp_no);


SELECT e.emp_no, e.first_name, de.dept_no
FROM employees as e
INNER Join dept_emp AS de USING(emp_no);
INNER JOIN departments AS c USING(emp_no);




