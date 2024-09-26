from returns.maybe import Maybe
from models import City
from typing import List
from returns.result import Result
import repositories.generic_repository as generic_repo

model = City


def find_by_id(city_id: int) -> Maybe[City]:
    return generic_repo.find_by_id(model, city_id)


def find_all() -> List[City]:
    return generic_repo.find_all(model)


def insert(city: City) -> Result[City, str]:
    return generic_repo.insert(city)


def update(city_id: int, city: City) -> Result[City, str]:
    return generic_repo.update(model, city_id, city)


def delete(city_id: int) -> Result[City, str]:
    return generic_repo.delete(model, city_id)
