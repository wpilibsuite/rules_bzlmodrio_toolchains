load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

filegroup_all = """filegroup(
    name = "all",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

def __setup_toolchains_dependencies(mctx):
    # bullseye-32
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/armhf-bullseye-2024-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "c7febfdb1f01ad7fd7876f8482f50ab4a875aeee77b12818fb97c4a76da789bd",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/armhf-bullseye-2024-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "0e3544b9cd8602f160e47c4b1593199ac6a600bce0dd9028be78a3ee7cc211fe",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/armhf-bullseye-2024-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "acc64f989c73c72a15e2296a6deee553458a1580e484e93b8ecd02cbf83e6af8",
        build_file_content = filegroup_all,
    )

    # bullseye-64
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/arm64-bullseye-2024-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "2774f894c59f1c390c4990ffaa6412776ea6a9dafc01accb50b8def72b8e6dbe",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/arm64-bullseye-2024-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "2cd4345315f165f273e21bbcf04638947fb7530a2859b728a564b6b97a7bea69",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/arm64-bullseye-2024-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "6ef1c81fe3fbc5578db111087a3715746bcdc59e67f10a50788c363ab5fb1368",
        build_file_content = filegroup_all,
    )

    # raspi-32
    maybe(
        http_archive,
        "bazelrio_raspi_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/armhf-raspi-bullseye-2024-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "2725fd7d1582d8503a2fdd1f7402e579cbbd1091b820b0fd50100d2205b78ba7",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/armhf-raspi-bullseye-2024-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "a8b19b6068fcedcae033d3bbefac9ae4a26139ab276304fe49302e4a992a9f7d",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/armhf-raspi-bullseye-2024-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "69429dc49f2571b2c933e751b8a25f7a3a45b285b3ae49bc6e9b01e065fc8630",
        build_file_content = filegroup_all,
    )

    # roborio
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/cortexa9_vfpv3-roborio-academic-2024-x86_64-apple-darwin-Toolchain-12.1.0.tgz",
        sha256 = "95eed7503f92e17f0e93ed6e5412d3ac6297b6a15773c90ef1a590f47f6fa467",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/cortexa9_vfpv3-roborio-academic-2024-x86_64-linux-gnu-Toolchain-12.1.0.tgz",
        sha256 = "10349791e4f9fa33100ee52a84e7f9ba4df581963818334771253369b0d12061",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2024-1/cortexa9_vfpv3-roborio-academic-2024-x86_64-w64-mingw32-Toolchain-12.1.0.zip",
        sha256 = "b367ab5d451603a97cd18a76193e860640230013a99baf216bb97dda1c353990",
        build_file_content = filegroup_all,
    )

def setup_legacy_setup_toolchains_dependencies():
    __setup_toolchains_dependencies(None)

deps = module_extension(
    __setup_toolchains_dependencies,
)
