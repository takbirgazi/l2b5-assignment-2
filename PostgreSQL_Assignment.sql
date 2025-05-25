-- Active: 1747412664382@@127.0.0.1@5432@conservation_db

CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(255) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(150) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
)

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL,
    species_id INT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(255) NOT NULL,
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    FOREIGN KEY (species_id) REFERENCES species (species_id)
);

INSERT INTO
    rangers (name, region)
VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES 
('Snow Leopard', 'Panthera uncia', '1775-01-01' , 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01','Endangered');

INSERT INTO sightings (ranger_id,species_id, sighting_time,location,notes)
VALUES
(2, 1, '2024-05-10 07:45:00', 'Peak Ridge', 'Camera trap image captured'),
(3, 2, '2024-05-12 16:20:00', 'Bankwood Area', 'Juvenile seen'),
(4, 3, '2024-05-15 09:10:00', 'Bamboo Grove East', 'Feeding observed'),
(2, 3, '2024-05-18 18:30:00', 'Snowfall Pass',NULL);

-- Problem 1
INSERT INTO
    rangers (name, region)
VALUES
('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE ('%Pass%');

-- Problem 4
SELECT rangers.name, COUNT(sightings) FROM sightings JOIN rangers ON sightings.ranger_id = rangers.ranger_id GROUP BY rangers.name;

-- Problem 5
SELECT common_name FROM species LEFT JOIN sightings ON species.species_id = sightings.species_id WHERE sightings.species_id IS NULL;

-- Problem 6
SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings
INNER JOIN species ON sightings.species_id = species.species_id
INNER JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

SELECT * FROM sightings;
