from sqlalchemy import text
from config.base import session_factory


def create_tables():
    create_table_script = """


    CREATE TABLE IF NOT EXISTS countries (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL
    );


    CREATE TABLE IF NOT EXISTS cities (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL
    );


    CREATE TABLE IF NOT EXISTS industries (
        id SERIAL PRIMARY KEY,
        industry VARCHAR(200) NOT NULL
    );


    CREATE TABLE IF NOT EXISTS target_types (
        id SERIAL PRIMARY KEY,
        type VARCHAR(100) NOT NULL
    );


    CREATE TABLE IF NOT EXISTS target_location (
        id SERIAL PRIMARY KEY,
        city_id INTEGER REFERENCES cities(id),
        country_id INTEGER REFERENCES countries(id)
    );


    CREATE TABLE IF NOT EXISTS coordinates (
        id SERIAL PRIMARY KEY,
        lat FLOAT,
        lon FLOAT
    );


    CREATE TABLE IF NOT EXISTS targets (
        id SERIAL PRIMARY KEY,
        coordinates_id INTEGER REFERENCES coordinates(id),
        location_id INTEGER REFERENCES target_location(id),
        type_id INTEGER REFERENCES target_types(id),
        industry_id INTEGER REFERENCES industries(id),
        priority INTEGER,
        mission_id INTEGER REFERENCES mission(mission_id)
    );


    """
    with session_factory() as session:
        session.execute(text(create_table_script))
        session.commit()


def drop_tables():
    delete_tables = """   
    DROP TABLE IF EXISTS targets CASCADE;
    DROP TABLE IF EXISTS target_location CASCADE;
    DROP TABLE IF EXISTS coordinates CASCADE;
    DROP TABLE IF EXISTS industries CASCADE;
    DROP TABLE IF EXISTS target_types CASCADE;
    DROP TABLE IF EXISTS cities CASCADE;
    DROP TABLE IF EXISTS countries CASCADE;
    """
    with session_factory() as session:
        session.execute(text(delete_tables))
        session.commit()


if __name__ == '__main__':
    drop_tables()
    create_tables()










