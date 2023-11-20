/* group by emp_no get the max salary in each group*/
SELECT emp_no , Max(From_date)
From salaries
Group BY emp_no;


/*year and salary may not correlate 100% same*/
SELECT emp_no , Max(From_date) , Max(salary)
From salaries
Group BY emp_no;

/*We can gather different analytics*/
SELECT emp_no , Max(From_date) as last_change , Max(salary) AS max_salary, Avg(salary) As average_earnings
From salaries
Group BY emp_no;