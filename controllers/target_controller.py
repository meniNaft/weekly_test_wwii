from dictalchemy.utils import asdict
from flask import Blueprint, jsonify
from models import ResponseDto
import repositories.target_repository as target_repo
from utils.utils_calss import convert_to_json

target_blueprint = Blueprint("targets", __name__)


@target_blueprint.route("/", methods=["GET"])
def find_all():
    my_list = [convert_to_json(target) for target in target_repo.find_all()]
    response = ResponseDto(body=my_list)
    return jsonify(response.__dict__), 200


@target_blueprint.route("/<int:target_id>", methods=["GET"])
def find_by_id(target_id: int):
    if not target_id:
        return jsonify(asdict(ResponseDto(error="no target_id passed"))), 400
    return (target_repo.find_by_id(target_id)
            .map(convert_to_json)
            .map(lambda t: (jsonify(ResponseDto(body=t)), 200))
            .value_or((jsonify(ResponseDto(error=f"target with {target_id} not found")), 404)))
