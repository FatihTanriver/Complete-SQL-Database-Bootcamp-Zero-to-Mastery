--What if we want to combine the results of multiple groupings?
-- Link: https://www.postgresql.org/docs/12/queries-table-expressions.html#QUERIES-GROUPING-SETS

SELECT col1, SUM(Col2) 
FROM table
Group By col1

UNION

SELECT SUM(Col2)
From table
--it makes one tabel

-- Union All vs Union 
-- Union remove duplicates
-- Union All does not remowe duplicates

-- Grouping SETS: 
-- a subclause of group by that allows you define multiple groupings

Select Null As "prod_id", sum(ol.quantity)
From orderlines AS ol

UNION

Select prod_id As "prod_id2", sum(ol.quantity)
From orderlines AS ol
GROUP bY prod_id
ORder By prod_id DESC;


Select sum(quantity) From orderlines 

-- In One query
-- Grouping Sets allows us to combine the outpus of multiple groupings
-- Grouping Sets can be used like Union
Select prod_id As "prod_id2", orderlineid ,sum(ol.quantity)
From orderlines AS ol
GROUP bY 
    Grouping Sets (
        (),         --  group by nothing 'null'
        (prod_id),   --  group by prod id
        (orderlineid)   -- group by orderline ID
    )
ORder By prod_id DESC ,orderlineid DESC;

--!! This gives us 
-- 1) all sum( money )
-- 2) orderline sum( money )
-- 3) product sum

/* !!! Footbal DB 
    1) Takimin attigi tum goller 
    2) Mevkilerin attigi tum goller
    3) Tek bir futbolcunun attigi goller
    
    olmak üzere 3 farkli gruplamayi tek bir query ile yapabiliriz

*/



---- ROLLUP