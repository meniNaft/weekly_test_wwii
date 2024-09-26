from returns.maybe import Maybe
from models import TargetType
from typing import List
from returns.result import Result
import repositories.generic_repository as generic_repo

model = TargetType


def find_by_id(target_type_id: int) -> Maybe[TargetType]:
    return generic_repo.find_by_id(model, target_type_id)


def find_all() -> List[TargetType]:
    return generic_repo.find_all(model)


def insert(target_type: TargetType) -> Result[TargetType, str]:
    return generic_repo.insert(target_type)


def update(target_type_id: int, target_type: TargetType) -> Result[TargetType, str]:
    return generic_repo.update(model, target_type_id, target_type)


def delete(target_type_id: int) -> Result[TargetType, str]:
    return generic_repo.delete(model, target_type_id)
