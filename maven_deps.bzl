load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

filegroup_all = """filegroup(
    name = "all",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

def __setup_toolchains_dependencies(mctx):
    release = "v2025-2"

    # bookworm-32
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "cbbfef87c1004923a01697424d6904097ff118efe0709ccd453544088693d5ab",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "2c0dd7352edf13f73bc802690876bf77e353265afad0acf677b1cff0cf62c7b0",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz",
        sha256 = "1dbb38120fd37cf5b69447cb93cb5c488b2a56bec72db4edcb3fa92ad3881b05",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip",
        sha256 = "85f75e41ec6cdee80ac4abc5cb2f1d235de67611663ecf6f69a64d05ba3591ef",
        build_file_content = filegroup_all,
    )

    # bookworm-64
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "4082238f6c726c9105cd85c52cfea80349ac57737e6a3915aa896246a201a5b7",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "6900a02b447d89fa31e7872071c1264b20188cb0c2456a634706bf884f3016ea",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz",
        sha256 = "7682bac991f106627ce6bd38c1f4dd552931700f3aee73534b4c10f119ad2899",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip",
        sha256 = "258d0209ec43302cd2b9e4ce7808f163db14a66a85383bd1880c4083f09dd22f",
        build_file_content = filegroup_all,
    )

    # raspi-bookworm-32
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-raspi-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "eca6d22a02f0a8b18723fadde0ef82ee2f31f20be8d258e4dbe8faed055547c7",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-raspi-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "f2dec8a3d9b8ccf30087454dbf4fcff0fd261f3a2a3f9cf08729b17d1ceb6101",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-raspi-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz",
        sha256 = "2ab8530d9cb7c00d148ad1a4ccc027d91d02f5f83da8077a1604dff9547d9c4d",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/armhf-raspi-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip",
        sha256 = "23c1c6434e761b6cc79e8622b1bcd575030a689801870ff795190f718d7fdc80",
        build_file_content = filegroup_all,
    )

    # roborio
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/cortexa9_vfpv3-roborio-academic-2025-arm64-apple-darwin-Toolchain-12.1.0.tgz",
        sha256 = "f55024a44d0d3243f4f88229baeb883e386193c99b18afdcbcefd12f6d913e35",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/cortexa9_vfpv3-roborio-academic-2025-x86_64-apple-darwin-Toolchain-12.1.0.tgz",
        sha256 = "02d412a98ccec9dbb410975513b388304ff9b475c74450fe42bf497b5400212b",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/cortexa9_vfpv3-roborio-academic-2025-x86_64-linux-gnu-Toolchain-12.1.0.tgz",
        sha256 = "e1aea36b35c48d81e146a12a4b7428af051e525fac18c85a53c7be98339cce9f",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/cortexa9_vfpv3-roborio-academic-2025-x86_64-w64-mingw32-Toolchain-12.1.0.zip",
        sha256 = "7f15de72cdacc738c3c0d33292c869a5785ad09b87478cf6af38daf4aab92b68",
        build_file_content = filegroup_all,
    )

    # systemcore
    maybe(
        http_archive,
        "bazelrio_systemcore_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "4082238f6c726c9105cd85c52cfea80349ac57737e6a3915aa896246a201a5b7",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_systemcore_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "6900a02b447d89fa31e7872071c1264b20188cb0c2456a634706bf884f3016ea",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_systemcore_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz",
        sha256 = "7682bac991f106627ce6bd38c1f4dd552931700f3aee73534b4c10f119ad2899",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_systemcore_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/arm64-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip",
        sha256 = "258d0209ec43302cd2b9e4ce7808f163db14a66a85383bd1880c4083f09dd22f",
        build_file_content = filegroup_all,
    )

def setup_legacy_setup_toolchains_dependencies():
    __setup_toolchains_dependencies(None)

deps = module_extension(
    __setup_toolchains_dependencies,
)
