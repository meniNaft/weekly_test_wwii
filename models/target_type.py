from config.base import Base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship


class TargetType(Base):
    __tablename__ = 'target_type'

    id = Column(Integer, primary_key=True, autoincrement=True)
    type = Column(String(100), nullable=False, unique=True)

    targets = relationship("Target", back_populates="target_type")