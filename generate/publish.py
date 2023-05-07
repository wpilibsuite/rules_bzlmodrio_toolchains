import os
from get_toolchain_dependencies import get_toolchain_dependencies
from bazelrio_gentool.publish_module import publish_module
from bazelrio_gentool.utils import TEMPLATE_BASE_DIR


def main():
    SCRIPT_DIR = os.environ["BUILD_WORKSPACE_DIRECTORY"]
    registry_location = os.path.join(
        SCRIPT_DIR, "..", "..", "..", "bazel-central-registry"
    )

    group = get_toolchain_dependencies()

    module_template = os.path.join(
        TEMPLATE_BASE_DIR, "toolchains", "MODULE.bazel.jinja2"
    )
    module_json_template = None

    os.chdir(SCRIPT_DIR)
    publish_module(registry_location, group, module_json_template, module_template)


if __name__ == "__main__":
    """
    bazel run //:publish
    """
    main()
