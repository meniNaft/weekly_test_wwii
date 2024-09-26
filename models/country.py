from config.base import Base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship


class Country(Base):
    __tablename__ = 'country'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), unique=True)

    cities = relationship("City", back_populates="country")
    targets = relationship("Target", back_populates="country")
