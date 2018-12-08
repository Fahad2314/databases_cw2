-- Part 1.4 dataIntegration.sql
--
-- Submitted by: Al-Fahad Abdul-Mumuni
-- 


--  Write your Data Integration statements here
-- Process the crimes2014  table ahead of the union with the other tables (crimes2013, crimes2015)

-- create a temp crimes2014 table which will take the data in the correct order to enable UNION of tables 
CREATE TABLE temp_crimes2014
(   
    dr_no INT NOT NULL ,
    date_reported VARCHAR(256) NOT NULL,
    date_occ VARCHAR(256) NOT NULL,
    time_occ VARCHAR(256) NOT NULL,
    area INT NOT NULL,
    area_name VARCHAR(256) NOT NULL,
    rd INT NOT NULL,
    crime_no INT NOT NULL,
    crime_desc VARCHAR(256) NOT NULL,
    status_ VARCHAR(256) NOT NULL,
    status_desc VARCHAR(256) NOT NULL,
    image_no INT  NULL
);

-- INSERT data from crimes2014 into temporary table in the correct order
INSERT INTO temp_crimes2014
(dr_no, date_reported, date_occ, time_occ, area, area_name, rd, crime_no, crime_desc, status_, status_desc,image_no)
SELECT 
dr_no,
date_reported,
date_occ,
time_occ,
area,
area_name,
rd ,
crime_no ,
crime_desc ,
status_ ,
status_desc ,
image_no 
FROM crimes2014;



--Rename temp_crimes to crimes2014 after dropping crimes2014
DROP TABLE crimes2014;
RENAME TABLE temp_crimes2014 TO crimes2014;


--create the crimes table schema
CREATE TABLE crimes
(   
    dr_no INT NOT NULL ,
    date_reported VARCHAR(256) NOT NULL,
    date_occ VARCHAR(256) NOT NULL,
    time_occ VARCHAR(256) NOT NULL,
    area INT NOT NULL,
    area_name VARCHAR(256) NOT NULL,
    rd INT NOT NULL,
    crime_no INT NOT NULL,
    crime_desc VARCHAR(256) NOT NULL,
    status_ VARCHAR(256) NOT NULL,
    status_desc VARCHAR(256) NOT NULL,
    image_no INT  NULL
);
--UNION OF ALL TABLES INSERT INTO  crimes table 
--make dr_no primary key in crimes2013
ALTER TABLE crimes2013
ADD PRIMARY KEY (dr_no);
--make dr_no auto_increment
ALTER TABLE crimes2013
MODIFY COLUMN  dr_no  INT NOT NULL AUTO_INCREMENT;
--make dr_no primary key in crimes2014
ALTER TABLE crimes2014
ADD PRIMARY KEY (dr_no);
--make dr_no auto_increment in crimes2014
ALTER TABLE crimes2014
MODIFY COLUMN  dr_no  INT NOT NULL AUTO_INCREMENT;
--make dr_no primary key in crimes2015
ALTER TABLE crimes2015
ADD PRIMARY KEY (dr_no);
--make dr_no auto_increment
ALTER TABLE crimes2015
MODIFY COLUMN  dr_no  INT NOT NULL AUTO_INCREMENT;

-- insert union of all tables into crimes table 
INSERT INTO crimes
(dr_no, date_reported, date_occ, time_occ, area, area_name, rd, crime_no, crime_desc, status_, status_desc,image_no)
SELECT 
*
FROM 
    (SELECT * FROM crimes2013
    UNION 
    SELECT *    FROM crimes2014
    UNION
    SELECT * FROM crimes2015) AS T1;
