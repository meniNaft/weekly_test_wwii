from flask import Flask
from controllers.target_controller import target_blueprint

app = Flask(__name__)
if __name__ == '__main__':
    app.register_blueprint(target_blueprint, url_prefix="/api/targets")
    app.run(debug=True, use_reloader=False)

