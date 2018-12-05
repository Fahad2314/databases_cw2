-- Part 2.2 optimization.sql
--
-- Submitted by: Al-Fahad Abdul-Mumuni
-- 


--  Write your SQL statements here

-- create a temporary images table which will include the hash key column 
ALTER TABLE image ADD COLUMN md5_image CHAR(32);

-- insert hash numbers into the image database so uniquely can identify each image i
UPDATE image
SET md5_image = MD5(image);

--create index on image search using md5_haskey
CREATE INDEX image_search ON image (image(10),md5_image);
