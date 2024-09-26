from returns.maybe import Maybe
from models import Country
from typing import List
from returns.result import Result
import repositories.generic_repository as generic_repo

model = Country


def find_by_id(country_id: int) -> Maybe[Country]:
    return generic_repo.find_by_id(model, country_id)


def find_all() -> List[Country]:
    return generic_repo.find_all(model)


def insert(country: Country) -> Result[Country, str]:
    return generic_repo.insert(country)


def update(country_id: int, country: Country) -> Result[Country, str]:
    return generic_repo.update(model, country_id, country)


def delete(country_id: int) -> Result[Country, str]:
    return generic_repo.delete(model, country_id)
