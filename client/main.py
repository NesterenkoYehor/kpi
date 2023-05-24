import json
import sys
from PySide6.QtCore import QObject, Slot, QSize
from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickView
import urllib3


class WorkWithServer(QObject):
    user = ""
    password = ""
    url = ""

    def load_data(self, settings_file: str):
        with open(settings_file) as file:
            settings: dict = json.load(file)
        self.url = settings.get("url")


    @staticmethod
    def send_data_to_server(url, data) -> str:
        http = urllib3.PoolManager()
        response: urllib3.HTTPResponse = http.request(
            "GET", url, fields=data)
        return response.data


    @Slot(str, str, result=bool)
    def login(self, login: str, password: str):
        self.user = login
        self.password = password
        response = self.send_data_to_server(
            self.url, {"from": "user", "name": login, "password": password})
        response = json.loads(response)
        if response["status"] == "fail":
            return False
        else:
            return True
        

    @Slot(result=str)
    def load_fields(self):
        response = self.send_data_to_server(
            f"{self.url}/get_fields", 
            {
                "from": "user", 
                "name": self.user, 
                "password": self.password
            })
        return str(response)[2:-3]


    @Slot(result=str)
    def load_users(self):
        response = self.send_data_to_server(
            f"{self.url}/get_users", 
            {
                "from": "user", 
                "name": self.user, 
                "password": self.password
            })
        return str(response)[2:-3]


def main():
    wws = WorkWithServer()
    wws.load_data("settings.json")
    app = QApplication(sys.argv)
    view = QQuickView()
    ctx = view.rootContext()
    ctx.setContextProperty("wws", wws)

    view.setSource("app.qml")
    view.setMaximumWidth(600)
    view.setMaximumHeight(400)
    view.setMinimumWidth(600)
    view.setMinimumHeight(400)
    view.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()