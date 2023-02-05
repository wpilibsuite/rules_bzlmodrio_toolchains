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
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/armhf-bullseye-2023-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "736aee2a1aa4c9c7743f949f052e9167c50c80adf6dc80c63020eb2145d14be7",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/armhf-bullseye-2023-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "49e913cdeb4ad6b800d6829fd4817c83241554dd9548d1b5650423e9122291e9",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/armhf-bullseye-2023-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "3c5e99446e8fcf668b85d8097de7367d7b119612323d8889a3abc29363ea050a",
        build_file_content = filegroup_all,
    )

    # bullseye-64
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/arm64-bullseye-2023-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "4c4976dc60e45876b876305d08d9940e448072ec1cbd0e4885747f2056626ebc",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/arm64-bullseye-2023-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "47278cd34a1d57e5ca821feaa4d9315f9656854e944f3218c8ec61812072b4f1",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/arm64-bullseye-2023-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "ebc0061cb908368bfaa3955ac9767fe08bbb07c7a8a61f33c43b28b90bd6d8b5",
        build_file_content = filegroup_all,
    )

    # raspi-32
    maybe(
        http_archive,
        "bazelrio_raspi_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/armhf-raspi-bullseye-2023-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "7a547cb200c9c7ceb0d1f42c73a9fa88950ec66870063c65d21d5684bfeee78a",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/armhf-raspi-bullseye-2023-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "477d77e13d3ac4a94cd56302e597578a453e8be465e3ef13a4339e2f7fdcee40",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/armhf-raspi-bullseye-2023-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "9a4f5864ce25c9450e421e64af166c6f0198a6282c64535d51c690317ee4a0ed",
        build_file_content = filegroup_all,
    )

    # roborio
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academic-2023-x86_64-apple-darwin-Toolchain-12.1.0.tgz",
        sha256 = "345bcbbc81958ad91dc87f51a94f1a709fdd7001b7f2995eaa016c04822f6d17",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academic-2023-x86_64-linux-gnu-Toolchain-12.1.0.tgz",
        sha256 = "f3d48103c311e07e4da5e6f2cae426d34d582b627c342f20407530f8cb1c93a1",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academic-2023-x86_64-w64-mingw32-Toolchain-12.1.0.zip",
        sha256 = "36b94b972fd017f6fd15a57ddbaa20e18616d72f7de16d9c81c03a1e58cb8475",
        build_file_content = filegroup_all,
    )

def setup_legacy_setup_toolchains_dependencies():
    __setup_toolchains_dependencies(None)

deps = module_extension(
    __setup_toolchains_dependencies,
)
