-- Part 1.3 dataPreprocessing.sql
--
-- Submitted by: Al-Fahad Abdul-Mumuni
-- 


-- Write your Data Preprocessing statements here


--REMOVE DUPLICATES crimes2013
CREATE TABLE temp_table2013 AS
SELECT * FROM crimes2013
GROUP BY dr_no;

DROP TABLE crimes2013;
RENAME TABLE temp_table2013 TO crimes2013;

-- REMOVE DUPLICATES crimes2014
CREATE TABLE temp_table2014 AS
SELECT * FROM crimes2014 
GROUP BY dr_no;

DROP TABLE crimes2014;
RENAME TABLE temp_table2014 TO crimes2014;

--REMOVE DUPLICATES crimes2015
CREATE TABLE temp_table2015 AS
SELECT * FROM crimes2015 
GROUP BY dr_no;

DROP TABLE crimes2015;
RENAME TABLE temp_table2015 TO crimes2015;

--FORMATTING TIMES IN TABLES

--Format time_occ in crimes2013
ALTER TABLE crimes2013
MODIFY COLUMN time_occ
TIME;

--Format time_occ in crimes2014
ALTER TABLE crimes2014
MODIFY COLUMN time_occ
TIME;

--Format time_occ in crimes2015
ALTER TABLE crimes2015
MODIFY COLUMN time_occ
TIME;

--IMAGE NUMBERS THAT ARE NEGATIVE
-- change image_no to NULL for crimes2013 where the image_no <1 
UPDATE crimes2013 
SET image_no = NULL
WHERE image_no < 1; 
--change image_no to NULL for crimes2014 where image_no <1 
UPDATE crimes2014
SET image_no = NULL
WHERE image_no < 1; 
--change image_no to NULL for crimes2015 where image_no <1
UPDATE crimes2015
SET image_no = NULL
WHERE image_no < 1; 

--CAPITALIZATION OF STATUS ATTRIBUTE 
--capitalize status_ in crimes2013
UPDATE crimes2013
SET status_ = UPPER(status_)
;
-- capitalize status_ in crimes2014
UPDATE crimes2014
SET status_ = UPPER(status_)
;
--change name of status in crimes2015 from reserved word status to status_
ALTER TABLE crimes2015 CHANGE COLUMN status status_ text;

--capitalize status_ in crimes2015
UPDATE crimes2015
SET status_ = UPPER(status_)
;

--STANDARDIZE DATE FORMATS
-- format dates in crimes2013
UPDATE crimes2013 
SET date_reported = STR_TO_DATE( date_reported, '%D %M, %Y');

UPDATE crimes2013
SET date_occ = STR_TO_DATE (date_occ, '%D %M, %Y');

-- format dates in crimes2014
UPDATE crimes2014
SET date_reported = (SELECT STR_TO_DATE(REPLACE(date_reported,"'",''), '%Y-%M-%d')); 

UPDATE crimes2014
SET date_occ = (SELECT STR_TO_DATE(REPLACE(date_occ,"'",''), '%Y-%M-%d')); 

--format dates in crimes2015
UPDATE crimes2015
SET date_reported = STR_TO_DATE(date_reported, '%m/%d/%Y');

UPDATE crimes2015
SET date_occ = STR_TO_DATE(date_occ, '%m/%d/%Y');

--Pre-processing crime number and crime descriptions with multiple descriptions per crime code
-- returns the crime no with multiple crime descriptions (crime_no 440 has multiple descriptions)
SELECT COUNT(DISTINCT(crime_desc)) AS unique_code, crime_no, crime_desc  
FROM crimes2013  
GROUP BY crime_no 
HAVING unique_code > 1 
ORDER BY unique_code DESC;

UPDATE crimes2013
SET crime_no = 1000
WHERE crime_desc= 'THEFT PLAIN - PETTY (UNDER $400)';

-- returns the crime no with multiple crime descriptions (crime no 930 and 813 have multiple descriptions )
SELECT COUNT(DISTINCT(crime_desc)) AS unique_code, crime_no, crime_desc  
FROM crimes2014 
GROUP BY crime_no 
HAVING unique_code > 1 
ORDER BY unique_code DESC;

--change the crime_no for crime_no 813 with the crime_desc 'CHILD ENDANGERMENT/NEG.' to crime_no 1001
UPDATE crimes2014
SET crime_no = 1001
WHERE crime_desc= "'CHILD ENDANGERMENT/NEG.' ";

--change the crime_no for crime_no 930 with the crime desc 'THREATS, VERBAL/TERRORIST' to crime_no 1002
UPDATE crimes2014
SET crime_no = 1002
WHERE crime_desc= "'THREATS, VERBAL/TERRORIST'";

-- crimes 2015 has no crime_no with multiple descriptions
SELECT COUNT(DISTINCT(crime_desc)) AS unique_code, crime_no, crime_desc  
FROM crimes2015 
GROUP BY crime_no 
HAVING unique_code > 1 
ORDER BY unique_code DESC;

