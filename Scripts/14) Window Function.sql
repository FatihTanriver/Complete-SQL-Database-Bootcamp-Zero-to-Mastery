/*Window functions
	Window functions create a new column
	based on functions performed on a subset 
	or 'Window' of the data
		!Data reference our query output data
*/

/*
	A window function performs a calculation across a set of table rows that are somehow 
	related to the current row. This is comparable to the type of calculation that can be 
	done with an aggregate function. But unlike regular aggregate functions, use of a 
	window function does not cause rows to become grouped into a single output row — the rows 
	retain their separate identities. Behind the scenes, the window function is able to access 
	more than just the current row of the query result.
*/

	/*
	In Football DB
		- Leagues Avg Investment to (GoalKeepers - Defense Squat - Offense Squat-  Attacking Squat)
	*/


	Select 
	*,
	MAX(salary) OVER() 
	From salaries;


	Select 
	*,
	MAX(salary) OVER() 
	From salaries Where salary < 70000;


	/*
		Partion By: 
			Divide Rows Into Groups  To Apply The Function
			Against (Optional)
	*/

	Select 
	*,
	AVG(salary) OVER(
		PARTITION By dp.dept_name
	) 
	From salaries
	Join dept_emp AS de USING (emp_no) 
	Join departments AS dp Using (dept_no);

	-- will give average of each departments salary next every single row.



/*
	Order by within Window functions
*/

	SELECT emp_no, Count(salary)
		Over(Order By emp_no AsC)
	From salaries;

	-- it order by make cumilative count( * )
	-- !!When we use 'order by'  in window function you're telling your query
	-- Make cumulative count?? !! Framing
	-- Without order by ; by de default the framing is  usually all partition rows

	/*This will group by each emp_no in a non-cumulative way*/
	SELECT emp_no, Count(salary)
		Over(PARTITION By emp_no)
	From salaries;


/*
	Using  Framin in  Window Fucntion
*/

	--!! when using a frame clause in a window function we can
	-- create a sub-range or frame.

	/*
		Partition By emp_no --we group it
		
		Group By  emp_no--
		
		FRAME Sytax:
			'KEY'										Meaning
			Rows or RANGE								whether you want to use a range or rows as a function
			Preceding									Rows before the current one
			Following									Rows after the current one
			Unbound Preceding or Following				Returns all before or after
			Current row									Your Current Row
	*/


	--ie
	PARTITION By category ORDER By price RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	
	
	--!!! Without order by ; by de default the framing is  usually all partition rows
	
	
		SELECT emp_no, Count(salary)
		Over(PARTITION By emp_no
			 ORDER By emp_no)
		From salaries;

		SELECT emp_no, Count(salary)
		Over(PARTITION By emp_no
			 ORDER By salary)
		From salaries;



		SELECT emp_no, Count(salary)
		Over(PARTITION By emp_no
			 ORDER By salary
			 RANGe BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
		From salaries;
		--!! UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
		-- Unbound current row, make it independent from 
		-- Preceding emp_no range or/and Following emp_no range
		
        SELECT emp_no, Count(salary)
		Over(PARTITION By emp_no
			 ORDER By salary
			 Rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
		From salaries;
		

	
