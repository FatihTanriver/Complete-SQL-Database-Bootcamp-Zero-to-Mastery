

-- Get Distinct Names and order by length of first_name
    --!! Wont work
    SELECT DISTINCT(first_name) FROM employees
    ORDER BY LENGTH( first_name);