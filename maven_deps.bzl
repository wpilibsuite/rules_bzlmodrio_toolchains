load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

filegroup_all = """filegroup(
    name = "all",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

def __setup_toolchains_dependencies(mctx):
    release = "v2027-1"

    HASHES = {
        "gcc_systemcore_debug_linux": ("arm64-systemcore-debug-2027-x86_64-linux-gnu-Toolchain-14.3.0.tgz", "ce8c7bea554d48cef44e2cfcf84591ed5824f3cdb4107ce5707a6fdae7452fd2"),
        "gcc_systemcore_debug_linuxaarch64": ("arm64-systemcore-debug-2027-aarch64-trixie-linux-gnu-Toolchain-14.3.0.tgz", "7dc8d930586cc2de2e6c8288a706146d419e6072573632a9a3ac91b693b45172"),
        "gcc_systemcore_debug_macos": ("arm64-systemcore-debug-2027-x86_64-apple-darwin-Toolchain-14.3.0.tgz", "003f0b6e752a9d177dfa45b614c012e911a2a92782189501c19a635d7d8899c1"),
        "gcc_systemcore_debug_macosarm": ("arm64-systemcore-debug-2027-arm64-apple-darwin-Toolchain-14.3.0.tgz", "103cf2b9fcf32c4c264570a0719c975dc597219bb41f926e55a4ed24babe2733"),
        "gcc_systemcore_debug_win": ("arm64-systemcore-debug-2027-x86_64-w64-mingw32-Toolchain-14.3.0.tgz", "5c1ad97f9174914229b7bb0dda36a995ae81d32d65e6f3a9bfcf4f122a94ecd1"),
        "gcc_systemcore_linux": ("arm64-systemcore-2027-x86_64-linux-gnu-Toolchain-14.3.0.tgz", "992d4f2037762588c062f5b22f282b92b9143a2e8cb39a2027e67249c8ed5bea"),
        "gcc_systemcore_linuxaarch64": ("arm64-systemcore-2027-aarch64-trixie-linux-gnu-Toolchain-14.3.0.tgz", "91eb185ee07efa58b16d03076e1d96afb3b551a3cc80f7195b573a3427790b3b"),
        "gcc_systemcore_macos": ("arm64-systemcore-2027-x86_64-apple-darwin-Toolchain-14.3.0.tgz", "b63b5b2165ea81686c05e2abe483b02293a98bfd6ce72690d74c864833028dbc"),
        "gcc_systemcore_macosarm": ("arm64-systemcore-2027-arm64-apple-darwin-Toolchain-14.3.0.tgz", "12a3b4feaf48b6567b1b85274b856b423103035c297cd50b31b31e1b74a275c8"),
        "gcc_systemcore_win": ("arm64-systemcore-2027-x86_64-w64-mingw32-Toolchain-14.3.0.tgz", "337f0bc3d1d0ecc7cfdb859c0994cbba05456b8344e67aaf56cabbe324fab4aa"),
        "gcc_trixie64_linux": ("arm64-trixie-2027-x86_64-linux-gnu-Toolchain-14.3.0.tgz", "76dd88aff88f2fda1ea0bfdb996e32a8a689c929dc492b874d5abd9a7c3ee06a"),
        "gcc_trixie64_linuxaarch64": ("arm64-trixie-2027-aarch64-trixie-linux-gnu-Toolchain-14.3.0.tgz", "6b93174a00d8affeb7325a69da1e2e7209dc8edf9b5f5467189972040797b7ac"),
        "gcc_trixie64_macos": ("arm64-trixie-2027-x86_64-apple-darwin-Toolchain-14.3.0.tgz", "e67b153e7cacf5dad7be349787f20a609085bbb00e61491783571f431fda991c"),
        "gcc_trixie64_macosarm": ("arm64-trixie-2027-arm64-apple-darwin-Toolchain-14.3.0.tgz", "6d39e865ecb141027b365f6b176101028bf3793c744768fd324c78e7333acbb6"),
        "gcc_trixie64_win": ("arm64-trixie-2027-x86_64-w64-mingw32-Toolchain-14.3.0.tgz", "9fffe71e7f3303fed7bdabfb7418cdc91c78a09466cccb0982bb0430d5ef581d"),
    }

    for archive_name, (release_type, hash) in HASHES.items():
        maybe(
            http_archive,
            archive_name,
            url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/" + release_type,
            sha256 = hash,
            build_file_content = filegroup_all,
        )

    return mctx.extension_metadata(
        reproducible = True,
    )

deps = module_extension(
    __setup_toolchains_dependencies,
)
