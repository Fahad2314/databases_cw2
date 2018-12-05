-- Part 1.2 dataLoading.sql
--
-- Submitted by: Al-Fahad Abdul-Mumuni
-- 


-- Part 1.2.1 Table Creation
CREATE TABLE crimes2013
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

CREATE TABLE crimes2014
(   
    date_reported VARCHAR(256) NOT NULL,
    dr_no INT NOT NULL ,
    date_occ VARCHAR(256) NOT NULL,
    time_occ VARCHAR(256) NOT NULL,
    area INT NOT NULL,
    area_name VARCHAR(256) NOT NULL,
    rd INT NOT NULL,
    crime_no INT NOT NULL,
    crime_desc VARCHAR(256) NOT NULL,
    status_ VARCHAR(256) NOT NULL,
    status_desc VARCHAR(256) NOT NULL,
    image_no INT
);



-- Part 1.2.1 Data Load
-- Load the crimes2013.txt file into the table created 
LOAD DATA LOCAL INFILE 'crimes2013.txt' INTO TABLE crimes2013
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''''
IGNORE 1 LINES;

--Load the crimes2014.csv file into the table created
LOAD DATA LOCAL INFILE 'crimes2014.csv' INTO TABLE crimes2014
COLUMNS TERMINATED BY ';'
ENCLOSED BY ''''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


