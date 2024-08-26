from collections.abc import Iterator
import os

import yaml

from picture_bed import LskyPictureBed
from utils import FileUtil


class LskyUploader:
    __config: dict
    __picture_bed: LskyPictureBed

    __unsupported_folder_name = "unsupported_files"
    __uploaded_folder_name = "uploaded_images"
    __allowed_permission = {"public", "private"}
    __allowed_suffix = {
        ".jpeg",
        ".jpg",
        ".png",
        ".gif",
        ".tif",
        ".bmp",
        ".ico",
        ".psd",
        ".webp",
    }

    def __init__(self, config: dict):
        self.__config = config
        self.__picture_bed = LskyPictureBed(
            self.__config["server"],
            self.__config["token"],
            self.__config["disable_ssl"],
        )

    def upload_albums(self):
        configs = map(self.__get_config, self.__config["albums"])
        configs = filter(self.__check_config, configs)
        for config in configs:
            self.__upload_album(config)

    def __get_config(self, album_config: dict) -> dict:
        album_id = self.__picture_bed.album_id(album_config["name"])
        album_path = album_config["path"]
        album_permission = album_config["permission"]
        album_delete_image = album_config["delete_image"]
        album_time_rename = album_config["time_rename"]
        return {
            "album_id": album_id,
            "album_path": album_path,
            "album_permission": album_permission,
            "album_delete_image": album_delete_image,
            "album_time_rename": album_time_rename,
        }

    @staticmethod
    def __check_config(config: dict) -> bool:
        return (
            config["album_id"] is not None
            and os.path.exists(config["album_path"])
            and config["album_permission"] in LskyUploader.__allowed_permission
        )

    def __upload_album(self, config: dict):
        for root, _, files in os.walk(config["album_path"], topdown=False):
            paths = self.__get_supported_paths(root, files)
            for image in self.__get_images(paths):
                self.__upload_image(image, config)
            for file in self.__get_other_files(paths):
                FileUtil.move_to_subfolder(file, self.__unsupported_folder_name)

    @staticmethod
    def __get_supported_paths(root: str, files: list) -> list:
        return [
            os.path.join(root, f)
            for f in files
            if not LskyUploader.__is_exclude_file(os.path.join(root, f))
        ]

    @staticmethod
    def __is_exclude_file(file_path: str) -> bool:
        return (
            LskyUploader.__unsupported_folder_name in file_path
            or LskyUploader.__uploaded_folder_name in file_path
        )

    @staticmethod
    def __get_images(paths: list) -> Iterator:
        return filter(LskyUploader.__check_image, paths)

    @staticmethod
    def __get_other_files(paths: list) -> Iterator:
        return filter(lambda p: not LskyUploader.__check_image(p), paths)

    @staticmethod
    def __check_image(file_name: str) -> bool:
        file_suffix = os.path.splitext(file_name)[1].lower()
        return file_suffix in LskyUploader.__allowed_suffix

    def __upload_image(self, file_path: str, config: dict):
        if config["album_time_rename"]:
            file_path = FileUtil.time_rename(file_path)
        if not self.__picture_bed.upload_image(
            file_path, config["album_permission"], config["album_id"]
        ):
            return
        if config["album_delete_image"]:
            os.remove(file_path)
        else:
            FileUtil.move_to_subfolder(file_path, self.__uploaded_folder_name)


if __name__ == "__main__":
    with open("auto_upload.yaml", "r") as f:
        config = yaml.safe_load(f)
    uploader = LskyUploader(config)
    uploader.upload_albums()
