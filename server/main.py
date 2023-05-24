import argparse
import json
from flask import Flask, request, jsonify, Response
import logging
from tools.database import Database
from tools.middleware import Middleware
from werkzeug.exceptions import BadRequest

database = Database(dbname="agronomia")
app = Flask(__name__)
app.wsgi_app = Middleware(app.wsgi_app, database)


@app.route("/get_users", methods=["GET", "POST"])
def get_users():
    try:
        req: dict = request.args.to_dict()
        del req["name"]
        del req["password"]
        del req["from"]
        data, _ = database.get_users(req or {}) or {}
    except KeyError:
        res = Response(
            '{"status": "fail", "summary": "it must have name"}', 400)
    except TypeError:
        res = Response(
            '{"status": "fail", "summary": "it must have name"}', 400)
    except Exception as ex_:
        logging.error(ex_)
        res = Response(
            '{"status": "fail", "summary": "error in server"}', 500)
    else:
        res = (jsonify(status="ok", data=list(data)), 200)
    return res


@app.route("/get_fields", methods=["GET", "POST"])
def get_fields():
    try:
        req: dict = request.args.to_dict()
        del req["name"]
        del req["password"]
        del req["from"]
        data, _ = database.get_fields(req) or {}
    except KeyError:
        res = Response(
            '{"status": "fail", "summary": "it must have name"}', 400)
    except TypeError:
        res = Response(
            '{"status": "fail", "summary": "it must have name"}', 400)
    except Exception as ex_:
        logging.error(ex_)
        res = Response(
            '{"status": "fail", "summary": "error in server"}', 500)
    else:
        res = (jsonify(status="ok", data=list(data)), 200)
    return res


@app.route("/get_data_from_field", methods=["GET", "POST"])
def get_data_from_field():
    try:
        req: dict = request.args.to_dict()
        data = database.get_field(req["field_name"])
        if not data:
            raise ValueError
    except KeyError:
        res = Response(
            '{"status": "fail", "summary": "it must have name"}', 400)
    except TypeError:
        res = Response(
            '{"status": "fail", "summary": "it must have name"}', 400)
    except BadRequest:
        res = Response(
            '{"status": "fail", "summary": "bad request"}', 400)
    except Exception as ex_:
        logging.error(ex_)
        res = Response(
            '{"status": "fail", "summary": "error in server"}', 500)
    else:
        res = (jsonify(status="ok", data=list(data)), 200)
    return res


@app.route("/update_field_data", methods=["GET", "POST"])
def update_field_data():
    try:
        req: dict = request.args.to_dict()
        del req["password"]
        del req["from"]
        database.update_field(req["name"], req)
    except BadRequest as ex_:
        logging.info(ex_)
        res = Response(
            '{"status": "fail", "summary": "bad request"}', 400)
    except KeyError as ex_:
        res = Response(
            '{"status": "fail", "summary": "there is not ' + str(ex_) + '"}', 
            400)
    except TypeError as ex_:
        res = Response(
            '{"status": "fail", "summary": "there is not ' + str(ex_) + '"}', 
            400)
    except Exception as ex_:
        logging.error(ex_)
        res = Response(
            '{"status": "fail", "summary": "error in server"}', 500)
    else:
        res = Response(
            '{"status": "ok", "summary": "data was successesfully updated"}',
            201)
    return res


@app.route("/", methods=["GET", "POST"])
def auth():
    return Response('{"status": "ok"}', 201)

def main():
    logging.basicConfig(
        level=logging.INFO,
        format=("%(asctime)s - %(module)s - " 
             "%(levelname)s - %(funcName)s: "
             "%(lineno)d - %(message)s"),
        datefmt='%H:%M:%S'
    )
    parser = argparse.ArgumentParser()
    parser.add_argument("--host")
    parser.add_argument("--port", type=int)
    args = parser.parse_args()
    app.run(args.host, args.port)


if __name__ == "__main__":
    main()