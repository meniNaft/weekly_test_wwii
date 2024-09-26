from returns.maybe import Maybe
from models import Position
from typing import List
from returns.result import Result
import repositories.generic_repository as generic_repo

model = Position


def find_by_id(position_id: int) -> Maybe[Position]:
    return generic_repo.find_by_id(model, position_id)


def find_all() -> List[Position]:
    return generic_repo.find_all(model)


def insert(position: Position) -> Result[Position, str]:
    return generic_repo.insert(position)


def update(position_id: int, position: Position) -> Result[Position, str]:
    return generic_repo.update(model, position_id, position)


def delete(position_id: int) -> Result[Position, str]:
    return generic_repo.delete(model, position_id)
