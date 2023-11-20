

---From -> Where -> Group by ->Select -> Order by

--Give me a list of all employees in the company

SELECT  * FROM  employees;

--How many Departmants are there in the company
SELECT  Count(*) FROM  departments;

--How many times has employee 10001 had a raise?
SELECT *  FROM Salaries WHERE emp_no = 10001;
SELECT Count(*) - 1  FROM Salaries WHERE emp_no = 10001;
		
--What Title Does 10006(Employee) Have?
SELECT title FROM titles WHERE emp_no = 10006;

--#Renaming Columns (for Output)
SELECT emp_no AS "Employee Number" FROM  employees; 

--Concat first and last name of the employee into one column
SELECT CONCAT(first_name, ' ', last_name ) AS "Full Name" FROM employees;


/*Select the employee with the name MAYUMI SCHUELLER
* Fullname is not column, but we concat firstname and lastname 
* For case sensitivity we should uppercase or concat result
*/
SELECT * FROM employees WHERE Upper(CONCAT(first_name, ' ' , last_name)) = 'MAYUMI SCHUELLER'; -- 287 ms

SELECT * FROM employees WHERE first_name = 'Mayumi' AND last_name = 'Schueller'; --129 ms

SELECT * FROM employees WHERE Upper(first_name) = 'MAYUMI' AND Upper(last_name) = 'SCHUELLER'; --190 ms

SELECT * FROM EmPloyees;
		 