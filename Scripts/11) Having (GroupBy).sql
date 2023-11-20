
/*
	Having
*/

	-- ! "Where" applies filters to individual rows
	--"HAVING" applies filters to a group as a whole
	
	
SELECT em.emp_no, em.first_name, em.last_name, dps.dept_name
FROM employees as em
INNER Join dept_emp AS de On a.emp_no = de.emp_no
INNER JOIN departments AS dps ON de.dept_no = dps.dept_no;


/*
EXERCISES
*/

--SELECT em.emp_no, em.first_name, em.last_name, dps.dept_name --!! This won't work with group by
SELECT  dps.dept_name, Count(em.emp_no) AS "# of employees"
FROM employees as em
INNER Join dept_emp AS de On em.emp_no = de.emp_no
INNER JOIN departments AS dps ON de.dept_no = dps.dept_no
-- WHERE em.gender = 'F'
Group By dps.dept_name
-- HAVING count(e.emp_no) > 25000

--** we can't use aggreate functions in WHERE clause
-- Single row filter with 'having' will not work. 


/*
 Order by Groups
*/


/*
*  Show me all the employees, hired after 1991, that have had more than 2 titles
*  Database: Employees
*/

    SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, count(t.title)
    FROM employees as e
    LEFT Join titles t On e.emp_no = t.emp_no
    Where e.hire_date > date '31-12-1991'
    GROUP BY e.emp_no
    HAving count(t.title) > 2
    Order By count(t.title) DESC;

    --Sol
    SELECT e.emp_no, count(t.title) as "amount of titles"
    FROM employees as e
    JOIN titles as t USING(emp_no)
    WHERE EXTRACT (YEAR FROM e.hire_date) > 1991
    GROUP BY e.emp_no
    HAVING count(t.title) > 2
    ORDER BY e.emp_no;


/*
*  Show me all the employees that have had more than 15 salary changes that work in the department development
*  Database: Employees
*/

    SELECT  em.first_name, em.last_name, Count(sl.salary)
    FRom employees as em
    Join salaries AS sl ON sl.emp_no = em.emp_no
    Join dept_emp AS de ON de.emp_no = em.emp_no
    WHERE de.dept_no = 'd005'
    GROUP By  em.emp_no
    HAVING  Count(sl.salary) > 15
    ORDER BY Count(sl.salary) DESC;
    
    --Sol
    SELECT e.emp_no, count(s.from_date) as "amount of raises"
    FROM employees as e
    JOIN salaries as s USING(emp_no)
    JOIN dept_emp AS de USING(emp_no)
    WHERE de.dept_no = 'd005'
    GROUP BY e.emp_no
    HAVING count(s.from_date) > 15
    ORDER BY e.emp_no;
    

/*
*  Show me all the employees that have worked for multiple departments
*  Database: Employees
*/

    SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, count(de.dept_no)
    FROM employees as e
    LEFT Join dept_emp de On e.emp_no = de.emp_no
    --Where e.hire_date > date '31-12-1991'
    GROUP BY e.emp_no
    HAving count(de.dept_no) > 1
    --Order By count(de.dept_no) DESC;
    ORDER BY e.emp_no;

    --Sol
    SELECT e.emp_no, count(de.dept_no) as "worked for # departments"
    FROM employees as e
    JOIN dept_emp AS de USING(emp_no)
    GROUP BY e.emp_no
    HAVING count(de.dept_no) > 1
    ORDER BY e.emp_no;
