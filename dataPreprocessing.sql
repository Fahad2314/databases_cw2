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

UPDATE crimes2013
SET time_occ = DATE_FORMAT(STR_TO_DATE(time_occ/100, '%H.%i'), '%H:%i');



--Format time_occ in crimes2014

UPDATE crimes2014
SET time_occ = DATE_FORMAT(STR_TO_DATE(time_occ/100, '%H.%i'), '%H:%i');


--Format time_occ in crimes2015

UPDATE crimes2015
SET time_occ = SUBSTRING(time_occ,1,5);


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
SET date_reported = STR_TO_DATE(date_reported, '%Y-%M-%d');

UPDATE crimes2014
SET date_occ = STR_TO_DATE(date_occ, '%Y-%M-%d');

--format dates in crimes2015
UPDATE crimes2015
SET date_reported = STR_TO_DATE(date_reported, '%m/%d/%Y');

UPDATE crimes2015
SET date_occ = STR_TO_DATE(date_occ, '%m/%d/%Y');





