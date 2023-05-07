import os
import argparse
from get_toolchain_dependencies import get_toolchain_dependencies

from bazelrio_gentool.cli import add_generic_cli, GenericCliArgs
from bazelrio_gentool.generate_toolchain import generate_toolchain
from bazelrio_gentool.clean_existing_version import clean_existing_version
from bazelrio_gentool.generate_module_project_files import (
    create_default_mandatory_settings,
)


def main():
    SCRIPT_DIR = os.environ["BUILD_WORKSPACE_DIRECTORY"]
    REPO_DIR = os.path.join(SCRIPT_DIR, "..")

    parser = argparse.ArgumentParser()
    add_generic_cli(parser)
    args = parser.parse_args()

    container = get_toolchain_dependencies()
    mandatory_dependencies = create_default_mandatory_settings(GenericCliArgs(args))

    clean_existing_version(
        REPO_DIR,
        extra_dir_blacklist=["jni"],
        file_blacklist=["tests/defines_helper.bzl", "constraints/combined/BUILD.bazel"],
    )
    generate_toolchain(REPO_DIR, container, mandatory_dependencies)


if __name__ == "__main__":
    """
    bazel run //:generate
    """
    main()
