load("@rules_bzlmodrio_toolchains//:maven_deps.bzl", "setup_legacy_setup_toolchains_dependencies")

setup_legacy_setup_toolchains_dependencies()

load("@rules_bzlmodrio_toolchains//toolchains:load_toolchains.bzl", "load_toolchains")

load_toolchains()

register_toolchains(
    "@local_bullseye_32//:macos",
    "@local_bullseye_32//:linux",
    "@local_bullseye_32//:windows",
    "@local_bullseye_64//:macos",
    "@local_bullseye_64//:linux",
    "@local_bullseye_64//:windows",
    "@local_raspi_32//:macos",
    "@local_raspi_32//:linux",
    "@local_raspi_32//:windows",
    "@local_roborio//:macos",
    "@local_roborio//:linux",
    "@local_roborio//:windows",
)
