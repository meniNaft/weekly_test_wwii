from config.base import Base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship


class TargetIndustry(Base):
    __tablename__ = 'target_industry'

    id = Column(Integer, primary_key=True, autoincrement=True)
    industry = Column(String(200), nullable=False, unique=True)

    targets = relationship("Target", back_populates="target_industry")