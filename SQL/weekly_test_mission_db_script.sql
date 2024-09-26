CREATE TABLE IF NOT EXISTS country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS city (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country_id INTEGER,
    CONSTRAINT fk_country FOREIGN KEY (country_id) REFERENCES country(id) 
);

CREATE TABLE IF NOT EXISTS target_type (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100) NOT NULL UNIQUE 
);

CREATE TABLE IF NOT EXISTS target_industry (
    id SERIAL PRIMARY KEY,
    industry VARCHAR(200) NOT NULL UNIQUE 
);

CREATE TABLE IF NOT EXISTS position (
    id SERIAL PRIMARY KEY,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    UNIQUE (latitude, longitude) 
);

CREATE TABLE IF NOT EXISTS target (
    id SERIAL PRIMARY KEY,
    country_id INTEGER,
    city_id INTEGER,
    target_type_id INTEGER,
    target_industry_id INTEGER,
    position_id INTEGER,
    CONSTRAINT fk_country_target FOREIGN KEY (country_id) REFERENCES country(id),
    CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES city(id),
    CONSTRAINT fk_target_type FOREIGN KEY (target_type_id) REFERENCES target_type(id), 
    CONSTRAINT fk_target_industry FOREIGN KEY (target_industry_id) REFERENCES target_industry(id),
    CONSTRAINT fk_position FOREIGN KEY (position_id) REFERENCES position(id) 
);

INSERT INTO country (name)
SELECT DISTINCT target_country
FROM mission 
WHERE target_country IS NOT NULL;

INSERT INTO target_type (type)
SELECT DISTINCT target_type
FROM mission 
WHERE target_type IS NOT NULL;

INSERT INTO target_industry (industry)
SELECT DISTINCT target_industry
FROM mission 
WHERE target_industry IS NOT NULL;

INSERT INTO position (latitude, longitude)
SELECT DISTINCT target_latitude, target_longitude
FROM mission 
WHERE target_latitude IS NOT NULL AND target_longitude IS NOT NULL;

INSERT INTO city (name, country_id)
SELECT DISTINCT m.target_city, c.id
FROM mission m
JOIN country c ON c.name = m.target_country
WHERE m.target_city IS NOT NULL;

INSERT INTO target (country_id, city_id, target_type_id, target_industry_id, position_id)
SELECT c.id, c2.id, tt.id, ti.id, p.id
FROM mission m 
LEFT JOIN country c ON c.name = m.target_country
LEFT JOIN city c2 ON c2.name = m.target_city AND c2.country_id = c.id
LEFT JOIN target_type tt ON tt.type = m.target_type 
LEFT JOIN target_industry ti ON ti.industry = m.target_industry 
LEFT JOIN position p ON p.latitude = m.target_latitude AND p.longitude = m.target_longitude
WHERE c2.id IS NOT NULL OR tt.id IS NOT NULL OR ti.id IS NOT NULL OR p.id IS NOT NULL;

