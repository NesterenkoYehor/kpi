import json
import random
import logging
import time
import urllib3


def get_bal():
    return random.randint(55, 75)


def get_ph():
    return random.randint(5, 8)


def get_gumus():
    return random.randint(2, 10)


def get_azot():
    return random.randint(1, 10)


def get_phosfor():
    return random.randint(1, 20)


def get_kaliy():
    return random.randint(10, 90)


def start_pooling(
    name: str,
    password: str,
    send_to: str,
):
    http = urllib3.PoolManager()
    while True:
        try:
            response: urllib3.HTTPResponse = http.request(
                method="GET",
                url=f"{send_to}",
                fields={
                    "name": name,
                    "password": password,
                    "from": "field",
                    "bal": get_bal(),
                    "ph": get_ph(),
                    "gumus": get_gumus(),
                    "azot": get_azot(),
                    "phosfor": get_phosfor(),
                    "kaliy": get_kaliy()
                }
            )
            logging.info(str(response.data))
        except Exception as ex_:
            logging.info(ex_)
        finally:
            time.sleep(180)
        

def main():
    logging.basicConfig(
        level=logging.INFO,
        format=("%(asctime)s - %(module)s - " 
             "%(levelname)s - %(funcName)s: "
             "%(lineno)d - %(message)s"),
        datefmt='%H:%M:%S'
    )
    with open("settings.json") as file:
        data = json.load(file)
    start_pooling(
        data["name"], data["password"], data["send_to"])
    

if __name__ == "__main__":
    main()