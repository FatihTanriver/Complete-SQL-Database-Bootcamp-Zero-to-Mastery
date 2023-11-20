


-- to get in-dept information by group
-- allows us chunks the data in two group
-- we use group by exculisively with aggr functions
-- every column not in the group-by must apply a function. \\dept_no, emp_no
--** to reduce all records found for the matching group to a single record
--- split-apply-combine
---		split:   	divide in two  groups with values
---		apply:		apply aggregate against ungrouped columns
---		combine: 	combines groups with a single value

--?? How many employees worked in each department?

Select dept_no, Count(emp_no) From dept_emp;
-- !! Spalte »dept_emp.dept_no« muss in der GROUP-BY-Klausel erscheinen oder in einer Aggregatfunktion verwendet werden

Select dept_no, Count(emp_no) From dept_emp
Group By dept_no Order by dept_no;


--*** We can order by with our aggreate function as well.

/*
	GROUP BY - Exercises
*/

	/*
	*  How many people were hired on any given hire date?
	*  Database: Employees
	*  Table: Employees
	*/

	SELECT e.hire_date, Count(e.emp_no)
	FROM employees as e
	Group By e.hire_date
	ORder By Count(e.emp_no) DEsc;

	/*
	*   Show me all the employees, hired after 1991 and count the amount of positions they've had
	*  Database: Employees
	*/

    SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, count(t.title)
    FROM employees as e
    LEFT Join titles t On e.emp_no = t.emp_no
    Where e.hire_date > date '31-12-1991'
    GROUP BY e.emp_no
    Order By e.hire_date;

	SELECT e.emp_no, count(t.title) as "amount of titles"
	FROM employees as e
	JOIN titles as t USING(emp_no)
	WHERE EXTRACT (YEAR FROM e.hire_date) > 1991
	GROUP BY e.emp_no
	ORDER BY e.emp_no;


	/*
	*  Show me all the employees that work in the department development
	*  Database: Employees
	*/

	SELECT e.emp_no, e.first_name
	FROM employees as e
	JOIN dept_emp AS de USING(emp_no)
	WHERE de.dept_no = 'd005'
	--GROUP BY e.emp_no
	ORDER BY e.emp_no;


