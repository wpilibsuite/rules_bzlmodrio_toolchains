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
    sha256 = "060426b186670beede4104095324a72bd7494d8b4e785bf0d84a612978285908",
    strip_prefix = "bazel-skylib-1.4.1",
    url = "https://github.com/bazelbuild/bazel-skylib/archive/refs/tags/1.4.1.tar.gz",
)
