from returns.maybe import Maybe
from models import TargetIndustry
from typing import List
from returns.result import Result
import repositories.generic_repository as generic_repo

model = TargetIndustry


def find_by_id(target_industry_id: int) -> Maybe[TargetIndustry]:
    return generic_repo.find_by_id(model, target_industry_id)


def find_all() -> List[TargetIndustry]:
    return generic_repo.find_all(model)


def insert(target_industry: TargetIndustry) -> Result[TargetIndustry, str]:
    return generic_repo.insert(target_industry)


def update(target_industry_id: int, target_industry: TargetIndustry) -> Result[TargetIndustry, str]:
    return generic_repo.update(model, target_industry_id, target_industry)


def delete(target_industry_id: int) -> Result[TargetIndustry, str]:
    return generic_repo.delete(model, target_industry_id)
