import os
import re
from bazelrio_gentool.auto_update_utils import get_latest_tag, split_tag


def main():
    latest_tag = get_latest_tag("wpilibsuite", "opensdk")

    overall_year, overall_version = latest_tag[1:].split("-")

    SCRIPT_DIR = os.environ["BUILD_WORKSPACE_DIRECTORY"]

    file_to_replace = os.path.join(SCRIPT_DIR, "get_toolchain_dependencies.py")

    with open(file_to_replace, "r") as f:
        contents = f.read()

    contents = re.sub(
        '( +)overall_year = "(.*)"', f'\\1overall_year = "{overall_year}"', contents
    )
    contents = re.sub(
        '( +)overall_version = f?"(.*)"',
        f'\\1overall_version = "{overall_version}"',
        contents,
    )

    with open(file_to_replace, "w") as f:
        f.write(contents)


if __name__ == "__main__":
    main()
