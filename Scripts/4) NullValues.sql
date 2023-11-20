/*
* When setting a val nullable
* Be Careful    :   is it required? (dont set null)
* Be Mindful    :   will be used for calculation? 
* Be Deliberate :   explain and protocol why you set it nullable
*/

--Checking for null values

SELECT 1 = 1; -- true

SELECT NULL = NULL; -- null

--Optional or required
--Rational build a team alone
--!! You can fast along, you can far together


--ex: You have 10k records and you add address column
--in order to clean 'Technical DEbt' setting nullable is logical no need re-clean or re-work to clean the data (temp address or empty value)


--Working with nulls in queries
-- 1)Filter out nulls
--!! name = NUll --wont work

SELECT  first_name, last_name FROM employees WHERE first_name = NULL; -- wont work
SELECT  first_name, last_name FROM employees WHERE first_name IS NULL;
SELECT first_name, last_name FROM employees WHERE NAME IS NOT NULL;


--Null Coalescing
--Be Defensive Clean your data

/*
*   firstname   lastname    age
*   NULL        tanriver    33
*   Rustam      NULL        NULL
*   NULL        Adeel       22
*/

SELECT COALESCE(firstname, 'no firstname available') , lastname FROM Student; 



--Execersises Null Coalescing
/*
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Assuming a students minimum age for the class is 15, what is the average age of a student?
*/

SELECT AVG(COALESCE(age, 15)) FROM "Student";


/*
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Replace all empty first or last names with a default?
*/


SELECT COALESCE(NAME, 'defName') AS NAME, COALESCE(lastName , 'defLN')  AS LastName FROM "Student"; 

--Sol2
SELECT id, COALESCE(NAME, 'fallback'), COALESCE(lastName, 'lastName'), age FROM "Student";



