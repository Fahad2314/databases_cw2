-- Part 1.5 databaseNormalization.sql
--
-- Submitted by: Al-Fahad Abdul-Mumuni
-- 


--  Write your Database Normalization statements here
-- database crimes is already in 2NF required to remove the transitive dependancies present in the table

--create temp crimes table which will be part on the 3NF tables
CREATE TABLE crimes_temp 
(
    dr_no  INT NOT NULL AUTO_INCREMENT,
    date_reported DATE  NULL,
    date_occ DATE  NULL,
    time_occ TIME  NULL,
    area INT  NULL,
    rd INT  NULL,
    crime_no INT NOT NULL,
    status_ VARCHAR(256) NOT NULL,
    image_no INT ,
    PRIMARY KEY(dr_no)
);

-- insert the relevant data into crimes_temp
INSERT INTO crimes_temp
(
    dr_no,
    date_reported,
    date_occ,
    time_occ,
    area,
    rd,
    crime_no,
    status_,
    image_no
)
SELECT * 
FROM 
    (SELECT 
        dr_no,
        date_reported,
        date_occ,
        time_occ,
        area,
        rd,
        crime_no,
        status_,
        image_no
    FROM crimes) AS T1;

-- create area 3NF table
CREATE TABLE rd_area_3NF
(
    rd INT(11) NOT NULL AUTO_INCREMENT,
    area  VARCHAR(255) NOT NULL,
    PRIMARY KEY (rd)
);

-- insert crime area and area_name into 3NF table
INSERT INTO rd_area_3NF
(   
    rd,
    area
)
SELECT *
FROM
(SELECT rd, area 
FROM crimes
GROUP BY rd) AS T1;

-- create area_areaname_3NF table
CREATE TABLE area_areaname_3NF
(
    area INT(11) NOT NULL AUTO_INCREMENT,
    area_name  VARCHAR(255) NOT NULL,
    PRIMARY KEY (area)
);
-- insert into area_areaname_3NF table 
INSERT INTO area_areaname_3NF
(   
    area,
    area_name
)
SELECT *
FROM
(SELECT area, area_name 
FROM crimes
GROUP BY area) AS T1;

-- create crime desc 3NF table
CREATE TABLE crimes_desc_3NF
(
    crime_desc VARCHAR(256) NOT NULL,
    crime_no  INT NOT NULL,
    PRIMARY KEY (crime_desc)
);
--insert into crime_desc 3NF table
INSERT INTO crimes_desc_3NF
(   
    crime_desc,
    crime_no
)
SELECT *
FROM
(SELECT crime_desc, crime_no 
FROM crimes
GROUP BY crime_desc) AS T1;

-- create status 3NF table
CREATE TABLE status_3NF
(
    status_ VARCHAR(256) NOT NULL,
    status_desc VARCHAR(256) NOT NULL,
    PRIMARY KEY(status_)
);
-- insert into the status 3NF table
INSERT INTO status_3NF
(   
    status_,
    status_desc
)
SELECT *
FROM
(SELECT status_, status_desc 
FROM crimes
GROUP BY status_) AS T1;

--create crimes_3NF
CREATE TABLE crimes_3NF
(
    dr_no INT NOT NULL AUTO_INCREMENT,
    date_reported VARCHAR(256) NOT NULL,
    date_occ VARCHAR(256) NOT NULL,
    time_occ VARCHAR(256) NOT NULL,
    rd INT NOT NULL,
    crime_desc VARCHAR(256) NOT NULL,
    status_ VARCHAR(256) NOT NULL, 
    image_no INT,
    PRIMARY KEY(dr_no),
    FOREIGN KEY(rd) REFERENCES rd_area_3NF(rd),
    FOREIGN KEY(crime_desc) REFERENCES crimes_desc_3NF(crime_desc),
    FOREIGN KEY(status_) REFERENCES status_3NF(status_)
);
-- insert into the crimes_3NF table 
INSERT INTO crimes_3NF
(
    dr_no,
    date_reported,
    date_occ,
    time_occ,
    rd,
    crime_desc,
    status_,
    image_no
) SELECT * 
FROM
    (SELECT  dr_no,
     date_reported,
    date_occ, 
    time_occ, 
    rd, 
    crime_desc,
    status_, 
    image_no
     FROM crimes) AS T1;


