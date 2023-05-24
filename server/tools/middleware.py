from .database import Database
import logging
from typing import Any
from werkzeug.wrappers import Request, Response, ResponseStream

class AuthError(Exception):
    pass

class Middleware:
    def __init__(self, app, db: Database) -> None:
        self.__app = app
        self.__db = db

    
    def __call__(self, environ, start_response: ResponseStream) -> Any:
        try:
            request = Request(environ)
            request_from = request.args["from"]
            name = request.args["name"]
            password = request.args["password"]
            is_ok = {
                "user": self.__db.auth_user,
                "field": self.__db.auth_field
            }[request_from](name, password)
            if not is_ok:
                raise AuthError
        except KeyError as ex_:
            res = Response(
                '{"status": "fail", "summary": "there is not ' + str(ex_) + '"}', 
                403)
        except AuthError:
            logging.info(f"{request.remote_addr} failed auth")
            res = Response(
                '{"status": "fail", "summary": "authorization failed"}', 403)
        except Exception as ex_:
            logging.error(ex_)
            res = Response(
                '{"status": "fail", "summary": "error in server"}', 500)
        else:
            res = self.__app

        return res(environ, start_response)
        