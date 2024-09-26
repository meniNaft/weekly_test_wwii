from config.base import Base
from sqlalchemy import Column, Integer, Float
from sqlalchemy.orm import relationship


class Position(Base):
    __tablename__ = 'position'

    id = Column(Integer, primary_key=True, autoincrement=True)
    latitude = Column(Float, nullable=False)
    longitude = Column(Float, nullable=False)
    targets = relationship("Target", back_populates="position")