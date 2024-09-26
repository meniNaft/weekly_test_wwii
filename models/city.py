from config.base import Base
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship



class City(Base):
    __tablename__ = 'city'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), nullable=False)
    country_id = Column(Integer, ForeignKey('country.id'))

    country = relationship("Country", back_populates="cities")
    targets = relationship("Target", back_populates="city")

    