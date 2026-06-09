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

    HASHES = {
        "gcc_bookworm32_linux": ("armhf-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz", "1dbb38120fd37cf5b69447cb93cb5c488b2a56bec72db4edcb3fa92ad3881b05"),
        "gcc_bookworm32_macos": ("armhf-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz", "2c0dd7352edf13f73bc802690876bf77e353265afad0acf677b1cff0cf62c7b0"),
        "gcc_bookworm32_macosarm": ("armhf-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz", "cbbfef87c1004923a01697424d6904097ff118efe0709ccd453544088693d5ab"),
        "gcc_bookworm32_win": ("armhf-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip", "85f75e41ec6cdee80ac4abc5cb2f1d235de67611663ecf6f69a64d05ba3591ef"),
        "gcc_bookworm64_linux": ("arm64-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz", "7682bac991f106627ce6bd38c1f4dd552931700f3aee73534b4c10f119ad2899"),
        "gcc_bookworm64_macos": ("arm64-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz", "6900a02b447d89fa31e7872071c1264b20188cb0c2456a634706bf884f3016ea"),
        "gcc_bookworm64_macosarm": ("arm64-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz", "4082238f6c726c9105cd85c52cfea80349ac57737e6a3915aa896246a201a5b7"),
        "gcc_bookworm64_win": ("arm64-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip", "258d0209ec43302cd2b9e4ce7808f163db14a66a85383bd1880c4083f09dd22f"),
        "gcc_roborio_linux": ("cortexa9_vfpv3-roborio-academic-2025-x86_64-linux-gnu-Toolchain-12.1.0.tgz", "e1aea36b35c48d81e146a12a4b7428af051e525fac18c85a53c7be98339cce9f"),
        "gcc_roborio_macos": ("cortexa9_vfpv3-roborio-academic-2025-x86_64-apple-darwin-Toolchain-12.1.0.tgz", "02d412a98ccec9dbb410975513b388304ff9b475c74450fe42bf497b5400212b"),
        "gcc_roborio_macosarm": ("cortexa9_vfpv3-roborio-academic-2025-arm64-apple-darwin-Toolchain-12.1.0.tgz", "f55024a44d0d3243f4f88229baeb883e386193c99b18afdcbcefd12f6d913e35"),
        "gcc_roborio_win": ("cortexa9_vfpv3-roborio-academic-2025-x86_64-w64-mingw32-Toolchain-12.1.0.zip", "7f15de72cdacc738c3c0d33292c869a5785ad09b87478cf6af38daf4aab92b68"),
        "gcc_rp_bookworm32_linux": ("armhf-raspi-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz", "2ab8530d9cb7c00d148ad1a4ccc027d91d02f5f83da8077a1604dff9547d9c4d"),
        "gcc_rp_bookworm32_macos": ("armhf-raspi-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz", "f2dec8a3d9b8ccf30087454dbf4fcff0fd261f3a2a3f9cf08729b17d1ceb6101"),
        "gcc_rp_bookworm32_macosarm": ("armhf-raspi-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz", "eca6d22a02f0a8b18723fadde0ef82ee2f31f20be8d258e4dbe8faed055547c7"),
        "gcc_rp_bookworm32_win": ("armhf-raspi-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip", "23c1c6434e761b6cc79e8622b1bcd575030a689801870ff795190f718d7fdc80"),
        "gcc_systemcore_linux": ("arm64-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz", "7682bac991f106627ce6bd38c1f4dd552931700f3aee73534b4c10f119ad2899"),
        "gcc_systemcore_macos": ("arm64-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz", "6900a02b447d89fa31e7872071c1264b20188cb0c2456a634706bf884f3016ea"),
        "gcc_systemcore_macosarm": ("arm64-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz", "4082238f6c726c9105cd85c52cfea80349ac57737e6a3915aa896246a201a5b7"),
        "gcc_systemcore_win": ("arm64-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip", "258d0209ec43302cd2b9e4ce7808f163db14a66a85383bd1880c4083f09dd22f"),
    }

    for archive_name, (release_type, hash) in HASHES.items():
        maybe(
            http_archive,
            archive_name,
            url = "https://github.com/wpilibsuite/opensdk/releases/download/" + release + "/" + release_type,
            sha256 = hash,
            build_file_content = filegroup_all,
        )

deps = module_extension(
    __setup_toolchains_dependencies,
)
