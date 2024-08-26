import requests
import urllib3


class LskyPictureBed:
    __server: str
    __token: str
    __server_verify: bool

    __upload_url: str = "/api/v1/upload"
    __albums_url: str = "/api/v1/albums"

    def __init__(self, server: str, token: str, disable_ssl: bool = False):
        if disable_ssl:
            urllib3.disable_warnings()
        self.__server = server
        self.__token = token
        self.__server_verify = not disable_ssl

    def upload_image(self, image_path: str, permission: str, album_id: int) -> bool:
        upload_header = {
            "Accept": "application/json",
            "Authorization": self.__token,
        }
        upload_file = {
            "file": open(image_path, "rb"),
        }
        upload_data = {
            "permission": self.__get_format_permission(permission),
            "album_id": album_id,
        }
        response = requests.post(
            url=self.__server + self.__upload_url,
            files=upload_file,
            data=upload_data,
            headers=upload_header,
            verify=self.__server_verify,
        )
        return self.__get_status(response.json())

    @staticmethod
    def __get_format_permission(permission: str) -> int:
        if permission == "public":
            return 1
        elif permission == "private":
            return 0
        raise ValueError("Invalid permission")

    @staticmethod
    def __get_status(response: dict) -> bool:
        if "status" in response:
            return response["status"]
        return False

    def album_id(self, album_name: str) -> int | None:
        get_header = {
            "Accept": "application/json",
            "Authorization": self.__token,
        }
        get_params = {"q": album_name}
        response = requests.get(
            url=self.__server + self.__albums_url,
            params=get_params,
            headers=get_header,
            verify=self.__server_verify,
        )
        if self.__get_status(response.json()):
            return self.__get_first_match_id(response.json(), album_name)
        return None

    @staticmethod
    def __get_first_match_id(response: dict, album_name: str) -> int | None:
        for album in response["data"]["data"]:
            if album["name"] == album_name:
                return album["id"]
        return None
