-- Part 2.1 constraints.sql
--
-- Submitted by: Al-Fahad Abdul-Mumuni
-- 


--  Write your CREATE TRIGGERS statements here
DELIMITER //
CREATE TRIGGER tr_insert_date_reported 
BEFORE INSERT ON crimes2015
FOR EACH ROW
BEGIN
IF NEW.date_reported < NEW.date_occ THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid crime reporting, crimes cannot be reported before they occur';
END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_update_date_reported
BEFORE UPDATE ON crimes2015
FOR EACH ROW
BEGIN 
IF NEW.date_reported < NEW.date_occ THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid crime reporting, crimes cannot be reported before they occur';
END IF ;
END // 
DELIMITER ;



--  Write your testing statements here
-- insert test entry into crimes2015 for the UPDATE statement 

-- statement to test if a crime can be reported before its occurance
INSERT INTO crimes2015
(
    dr_no,
    date_reported,
    date_occ,
    time_occ,
    area,
    area_name,
    rd,
    crime_no,
    crime_desc,
    status,
    status_desc,
    image_no
)
VALUES (
    1,
    '13/11/1994',
    '14/11,1994',
    '00:00:00',
    1,
    'Central',
    157,
    354,
    'THEFT OF IDENTITY',
    'IC',
    'Invest Cont',
    41
);

-- statement to test whether the UPDATE trigger is working
UPDATE crimes2015
SET date_reported = '12/31/2011'
WHERE dr_no = 150121272;
