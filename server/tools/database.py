import pymongo
import typing

class Database:
    def __init__(
        self, 
        host: str = "localhost", 
        port: int = 27017, 
        dbname: str = "pervashbot",
        user: str = None,
        password: str = None
    ) -> None:
        url = "mongodb://"

        if user and password:
            url += f"{user}:{password}@"
        
        url += f"{host}:{port}/{dbname}"
        self.__client = pymongo.MongoClient(url)
        self.__db = self.__client[dbname]


    def auth_user(self, user: str, password: str):
        if self.__db.users.find_one({"name": user, "password": password}):
            return True


    def get_user(self, user: str) -> typing.Union[dict, None]:
        return self.__db.users.find_one(
            {"name": user}, {"password": 0, "_id": 0})
    

    def get_users(self, *args) -> typing.Union[
        typing.Tuple[pymongo.CursorType, int], typing.Tuple[None, None]]:
        return self.__db.users.find(args[0], {"password": 0, "_id": 0}), \
                self.__db.users.count_documents(args[0])


    def auth_field(self, user: str, password: str):
        if self.__db.fields.find_one({"name": user, "password": password}):
            return True    


    def get_field(self, field_name: str) -> typing.Union[dict, None]:
        return self.__db.fields.find_one({"name": field_name}, 
            {"password": 0, "_id": 0})
    

    def update_field(self, field_name: str, data: dict):
        self.__db.fields.update_one({"name": field_name}, {"$set": {
            "bal": data["bal"],
            "ph": data["ph"],
            "gumus": data["gumus"],
            "azot": data["azot"],
            "phosfor": data["phosfor"],
            "kaliy": data["kaliy"]
        }})
    

    def get_fields(self, *args) -> typing.Union[
        typing.Tuple[pymongo.CursorType, int], typing.Tuple[None, None]]:
        return self.__db.fields.find(args[0], {"password": 0, "_id": 0}), \
                self.__db.fields.count_documents(args[0])