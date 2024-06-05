create table OLYMPICS_HISTORY( 
    id INT,
	name VARCHAR,
	sex VARCHAR,
	age VARCHAR,
	height VARCHAR,
	weight VARCHAR,  
	team VARCHAR,
	noc VARCHAR,
	game VARCHAR,
	year INT,
	season VARCHAR,
	city VARCHAR,
	sport VARCHAR,
	event VARCHAR,
	medal VARCHAR
 );
 
 select * from OLYMPICS_HISTORY;
 
 drop table OLYMPICS_HISTORY_NOC_REGIONS;
 create table OLYMPICS_HISTORY_NOC_REGIONS(
   noc VARCHAR,
   region VARCHAR,
   notes VARCHAR
 );
 
 insert into OLYMPICS_HISTORY_NOC_REGIONS (noc, region, notes) values ('AFG', 'Afghanistan', NULL);
 
 select * from OLYMPICS_HISTORY_NOC_REGIONS;
 
 copy OLYMPICS_HISTORY_NOC_REGIONS from 'D:\sql\noc-regions1.csv' DELIMITER ',' csv header;
 
 
--  queries: Count the number of athletes per region who have won medals and filter those regions with more than 50 medals. USING Query with GROUP BY, HAVING, and JOIN

 SELECT 
    nr.region, 
    COUNT(*) AS medal_count
FROM 
    OLYMPICS_HISTORY AS oh
JOIN 
    OLYMPICS_HISTORY_NOC_REGIONS AS nr
ON 
    oh.noc = nr.noc
WHERE 
    oh.medal IS NOT NULL
GROUP BY 
    nr.region
HAVING 
    COUNT(*) > 50;


-- queries: Find the names of athletes who participated in the most recent Olympics along with their respective regions.USING Subquery with JOIN

SELECT 
    oh.name, 
    nr.region
FROM 
    OLYMPICS_HISTORY AS oh
JOIN 
    OLYMPICS_HISTORY_NOC_REGIONS AS nr
ON 
    oh.noc = nr.noc
WHERE 
    oh.year = (SELECT MAX(year) FROM OLYMPICS_HISTORY);

 
-- queries: List the athletes whose names start with 'J', along with their sport and region. USING JOIN with WHERE and String Functions

SELECT 
    oh.name, 
    oh.sport, 
    nr.region
FROM 
    OLYMPICS_HISTORY AS oh
JOIN 
    OLYMPICS_HISTORY_NOC_REGIONS AS nr
ON 
    oh.noc = nr.noc
WHERE 
    oh.name LIKE 'J%';
	
	
-- queries: Date Functions and WHERE Clause.Find the athletes who participated after the year 2010 and sort them by year in descending order.

SELECT 
    id, 
    name, 
    year
FROM 
    OLYMPICS_HISTORY
WHERE 
    year > 2010
ORDER BY 
    year DESC;
	
	

-- queries:Using String Functions and WHERE. Find athletes whose names start with 'M' and who have won a medal.

SELECT 
    id, 
    name, 
    medal
FROM 
    OLYMPICS_HISTORY
WHERE 
    name LIKE 'M%' 
    AND medal IS NOT NULL;

