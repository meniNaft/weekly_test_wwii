from typing import Dict
from dictalchemy import asdict
from models import Target


def convert_to_json(target: Target) -> Dict[str, str]:
    # res = asdict(target.to_dict())
    return asdict(target)
