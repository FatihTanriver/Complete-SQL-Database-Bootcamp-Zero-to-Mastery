/*
* Dates and Timezones
*/ 
    -- Link: https://zachholman.com/talk/utc-is-enough-for-everyone-right
    -- SIR Sanford Fleming (Greenwich)
    -- GMT Greenwhich Mean Time (Time Zone)
    -- UTC Universal Cordinate time (Standard)
 
 
    
    
/*
* Setting Up Timezones
*/

SHOW timezone; -- Europe/Brussels 

ALTER USER postgres SET Timezone = 'UTC';

    
/*
* How Do We Format Date And Time
*/

-- PostgreSql ISO 8601
YYYY-MM-DDTHH:MM:SS


    
/*
* Timestamps
*/
SELECT now(); --2020-12-06 19:47:20.564943+00


CREATE TABLE timezones ( 
        ts TIMESTAMP WITHOUT TIME ZONE, 
        tz TIMESTAMP WITH TIME ZONE
        )


INSERT INTO timezones VALUES (
    TIMESTAMP WITHOUT TIME ZONE '2020-12-06 10:00:00-05',
    TIMESTAMP WITH TIME ZONE '2020-12-06 10:00:00-05'
);
    
SELECT * FROM timezones;
    
  
/*
* Date FUNCTIONS
*/
--!! Postgres gives us operators to help simplify dates

    SELECT CAST (now() AS date);    -- 2020-12-06
    SELECT NOW()::date;             -- 2020-12-06
    SELECT CURRENT_DATE;            -- 2020-12-06
    
    SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy'); -- 06/12/2020

    -- Template Patterns for Date/Time Formatting
    -- https://www.postgresql.org/docs/10/functions-formatting.html
    SELECT TO_CHAR(CURRENT_DATE, 'DDD');    -- 341  day of year (001-366)
    SELECT TO_CHAR(CURRENT_DATE, 'IDDD');   -- 343  day of ISO 8601 week-numbering year (001-371; day 1 of the year is Monday of the first ISO week)
    SELECT TO_CHAR(CURRENT_DATE, 'WW');    -- 49    week number of year (1-53) (the first week starts on the first day of the year)

    
/*
* Date Difference and Casting
*/

    SELECT now() - '1800/01/01' AS dayscount;
     
    -- to date( timestamp with time zone )

     SELECT date '1800/01/01'; -- 1800-01-01

    
/*
*  Age Calculation
*/
    SELECT AGE('1986-03-05'); // Err: 21:26:31 Kernel error: FEHLER:  Funktion age(UNKNOWN) ist nicht eindeutig
    --!! We need casting
    
    SELECT AGE(date '1986-03-05'); -- nows work
    
    -- between two specific date
    SELECT AGE(date '2011-07-19', date '1986-03-05');

/*
*  Extracting Information
*/
      SELECT EXTRACT(DAY FROM date '1986-03-05') AS Day_Of_Date;  -- 5
      SELECT EXTRACT(MONTH FROM date '1986-03-05') AS Month_Of_Date; -- 3
      SELECT EXTRACT(YEAR FROM date '1986-03-05') AS Year_Of_Date;  --1986
      
      SELECT DATE_TRUNC('year', date '1986-03-05'); -- truncate take the year and round down date
      SELECT DATE_TRUNC('month', date '1986-03-05'); -- truncate take the month and round down date
      SELECT DATE_TRUNC('day', date '1986-03-05'); -- truncate take the year and round down date !! but for timestamp it will round down the        timestamp
      
/*
*  Intervals
*/

    SELECT * 
    FROM orders 
    WHERE purchaseDate <= now() - INTERVAL '30 days';
    -- Where purchaseDate <= now() - interval '1 year 2 months 3 days'
    -- Where purchaseDate <= now() - interval '2 weeks ago'
    -- Where purchaseDate <= now() - interval '1 year 3 hours 20 minutes'

    SELECT
        EXTRACT (
            YEAR 
            FROM
                INTERVAL '5 years 20 months'
        );
        
       -- 6   // 20 months is more than a year
       

/*
*  Exercise: Date and Timestamp
*/


/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/

/*   SELECT
        EXTRACT (
            year 
            FROM
                 AGE(now(), date '1986-03-05')
        );
*/

SELECT CURRENT_DATE;                    --2020-12-06
SELECT AGE(date '1986-03-05');          -- 34 years 9 mons 1 day
SELECT AGE(now(),date '1986-03-05');    --34 years 9 mons 1 day 21:48:37.875759


SELECT * 
FROM employees 
WHERE  EXTRACT (
            YEAR 
            FROM
                 --AGE(now(), date '1986-03-05')
                 AGE(now(), birth_date)
        )  > 60 ;  

-- Instructor sol:
SELECT AGE(birth_date), * FROM employees
WHERE (
   EXTRACT (YEAR FROM AGE(birth_date))
) > 60 ;

-- alternative
SELECT count(birth_date) FROM employees
WHERE birth_date < now() - INTERVAL '61 years' -- 61 years before the current date

/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/

SELECT Count(*) FROM employees WHERE   EXTRACT(MONTH FROM hire_date) = 2;

/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/

SELECT Count(*) FROM employees WHERE EXTRACT(MONTH FROM birth_date) = 11;

/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/

SELECT AGE(now(), date '1986-03-05');
 
SELECT MAX(AGE(birth_date)) FROM employees;
       
SELECT * 
FROM employees
WHERE AGE(now(), birth_date) = (SELECT MAX(AGE(now(), birth_date)) FROM employees);


/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/

SELECT * 
FROM orders 
WHERE 
        EXTRACT(MONTH FROM orderdate) = 1 AND 
        EXTRACT(YEAR FROM orderdate) = 2004;

SELECT * 
FROM orders 
WHERE DATE_TRUNC('month', orderdate) = date '2004-01-01'


