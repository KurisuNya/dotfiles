import os
import shutil
import time


class FileUtil:
    __time_format = "%Y-%m-%d-%H-%M-%S"
    __milliseconds_format = "%-03d"

    @staticmethod
    def move_to_subfolder(file_path: str, subfolder: str):
        folder = os.path.dirname(file_path)
        path = os.path.join(folder, subfolder)
        os.makedirs(path, exist_ok=True)
        FileUtil.__move_avoid_conflict(file_path, path)

    @staticmethod
    def __move_avoid_conflict(file_path: str, path: str):
        new_file_path = os.path.join(path, os.path.basename(file_path))
        if os.path.exists(new_file_path):
            file_path = FileUtil.__name_add_time(file_path)
        shutil.move(file_path, path)

    @staticmethod
    def time_rename(file_path: str) -> str:
        time_stamp = FileUtil.__get_current_time()
        return FileUtil.__file_rename(file_path, time_stamp)

    @staticmethod
    def __name_add_time(file_path: str) -> str:
        time_stamp = FileUtil.__get_current_time()
        file_name = FileUtil.__get_file_name(file_path)
        new_name = file_name + "_" + time_stamp
        return FileUtil.__file_rename(file_path, new_name)

    @staticmethod
    def __get_current_time() -> str:
        current_time = time.time()
        local_time = time.localtime(current_time)
        data_head = time.strftime(FileUtil.__time_format, local_time)
        data_secs = (current_time - int(current_time)) * 1000
        time_stamp = ("%s" + FileUtil.__milliseconds_format) % (data_head, data_secs)
        return time_stamp

    @staticmethod
    def __file_rename(file_path: str, new_name: str) -> str:
        file_suffix = FileUtil.__get_file_suffix(file_path)
        file_root = os.path.dirname(file_path)
        rename_path = os.path.join(file_root, new_name + file_suffix)
        os.rename(file_path, rename_path)
        return rename_path

    @staticmethod
    def __get_file_name(file_path: str) -> str:
        return os.path.splitext(os.path.basename(file_path))[0]

    @staticmethod
    def __get_file_suffix(file_name: str) -> str:
        return os.path.splitext(file_name)[1].lower()
