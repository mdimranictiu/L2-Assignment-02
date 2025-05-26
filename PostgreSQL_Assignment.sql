-- create table 
CREATE Table rangers(ranger_id  SERIAL PRIMARY key, name VARCHAR(50), region VARCHAR(50));

CREATE TABLE species(species_id SERIAL PRIMARY KEY, common_name VARCHAR(100),scientific_name VARCHAR(100),discovery_date DATE,conservation_status VARCHAR(100));

CREATE TABLE sightings(sighting_id SERIAL PRIMARY KEY,species_id INTEGER REFERENCES species(species_id) ON DELETE CASCADE, ranger_id INTEGER REFERENCES rangers(ranger_id) ON DELETE CASCADE, location VARCHAR(100),sighting_time TIMESTAMP,notes TEXT DEFAULT NUll);

-- Sample Data Insertions
INSERT INTO rangers (name,region) VALUES('Alice Green','Northern Hills'),('Bob White','River Delta'),('Carol King',' Mountain Range');

INSERT INTO species(common_name,scientific_name,discovery_date,conservation_status) VALUES('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL);




-- problem 01
INSERT INTO rangers(name,region) VALUES('Derek Fox','Coastal Plains');

-- Problem 02
SELECT count(DISTINCT species_id)  as unique_species_count FROM sightings;

-- Problem 03
SELECT * from sightings WHERE location LIKE '%Pass%';

-- Problem 04

SELECT rangers.name ,COUNT(*) AS total_sightings from rangers INNER JOIN sightings on rangers.ranger_id=sightings.ranger_id GROUP BY rangers.name ;

-- Problem 05

SELECT common_name FROM species LEFT JOIN sightings ON species.species_id=sightings.species_id WHERE sightings.species_id is NULL;

-- Problem 06

SELECT 
species.common_name as common_name,
sightings.sighting_time as sighting_time,
rangers.name as name FROM sightings
JOIN rangers ON sightings.ranger_id=rangers.ranger_id
JOIN species on sightings.species_id=species.species_id
Order BY sightings.sighting_time DESC LIMIT 2;

-- Problem 07

UPDATE species SET conservation_status='Historic' WHERE extract(year from discovery_date)<1800;

-- Problem 08

SELECT sighting_id,
CASE 
    WHEN extract(Hour from sighting_time)<12 THEN 'Morning'  
    WHEN extract(Hour from sighting_time)>=12 AND extract(Hour from sighting_time)<17 THEN 'Afternoon'
    ELSE 'Evening' 
END As time_of_day
from sightings;


-- Problem 09

Delete from rangers
WHERE not EXISTS (
    select 1
    from sightings
    WHERE sightings.ranger_id = rangers.ranger_id
);
 