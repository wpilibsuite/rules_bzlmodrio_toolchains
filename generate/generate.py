import os
from get_toolchain_dependencies import get_toolchain_dependencies

from bazelrio_gentool.generate_toolchain import generate_toolchain
from bazelrio_gentool.clean_existing_version import clean_existing_version


def main():
    SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
    REPO_DIR = os.path.join(SCRIPT_DIR, "..")
    output_dir = os.path.join(REPO_DIR, "dependencies")

    container = get_toolchain_dependencies()

    clean_existing_version(REPO_DIR)
    generate_toolchain(REPO_DIR, container)


if __name__ == "__main__":
    """
    bazel run //:generate
    """
    main()
