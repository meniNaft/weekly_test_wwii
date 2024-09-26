from dotenv import load_dotenv
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import DeclarativeMeta, declarative_base

load_dotenv()
# engine = create_engine("postgresql://postgres:1234@localhost/movie_rental_project")
DB_URL = os.getenv("DB_URL")
engine = create_engine(DB_URL)
_SessionFactory = sessionmaker(bind=engine)
Base: DeclarativeMeta = declarative_base()


def session_factory():
    Base.metadata.create_all(engine)
    return _SessionFactory()
