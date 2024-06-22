workspace(name = "rules_bzlmodrio_toolchains")

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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    sha256 = "9f38886a40548c6e96c106b752f242130ee11aaa068a56ba7e56f4511f33e4f2",
    url = "https://github.com/bazelbuild/bazel-skylib/releases/download/1.6.1/bazel-skylib-1.6.1.tar.gz",
)
