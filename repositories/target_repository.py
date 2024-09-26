from returns.maybe import Maybe
from models import Target
from typing import List
from returns.result import Result
import repositories.generic_repository as generic_repo

model = Target


def find_by_id(target_id: int) -> Maybe[Target]:
    return generic_repo.find_by_id(model, target_id)


def find_all() -> List[Target]:
    return generic_repo.find_all(model)


def insert(target: Target) -> Result[Target, str]:
    return generic_repo.insert(target)


def update(target_id: int, target: Target) -> Result[   Target, str]:
    return generic_repo.update(model, target_id, target)


def delete(target_id: int) -> Result[Target, str]:
    return generic_repo.delete(model, target_id)
