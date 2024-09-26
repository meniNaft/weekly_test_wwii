from config.base import Base
from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy_serializer import SerializerMixin


class Target(Base, SerializerMixin):
    __tablename__ = 'target'

    id = Column(Integer, primary_key=True, autoincrement=True)
    country_id = Column(Integer, ForeignKey('country.id'))
    city_id = Column(Integer, ForeignKey('city.id'))
    target_type_id = Column(Integer, ForeignKey('target_type.id'))
    target_industry_id = Column(Integer, ForeignKey('target_industry.id'))
    position_id = Column(Integer, ForeignKey('position.id'))

    country = relationship("Country", back_populates="targets", lazy="joined")
    city = relationship("City", back_populates="targets", lazy="joined")
    target_type = relationship("TargetType", back_populates="targets", lazy="joined")
    target_industry = relationship("TargetIndustry", back_populates="targets", lazy="joined")
    position = relationship("Position", back_populates="targets", lazy="joined")
