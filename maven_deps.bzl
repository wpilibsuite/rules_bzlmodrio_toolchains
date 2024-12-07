load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

filegroup_all = """filegroup(
    name = "all",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

def __setup_toolchains_dependencies(mctx):
    # bookworm-32
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "dddddbd08ca3771581f9a77311191d60371b0e5dc4ba166450198f3a59c43d13",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "633fccbe1508478b095a03a05477795825971cdac0860bf3a0f79f5be2f73a5a",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz",
        sha256 = "3a0d0b350c359c8a46ce58e654ba4d5e97177833f0181792151401fe110aac32",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip",
        sha256 = "d0af53f4191d09c36ba189d9e20d9524dc164847c8c39e4f5ca961fe8d5eb056",
        build_file_content = filegroup_all,
    )

    # bookworm-64
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "e29fa2433cee667d75ff106543d88d3d4154e2f450c79d86d316d5b8015d11e4",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "34af7c9b601bbce1fe5c5e07f70fe8abd7ed3985cc603dbc12ef7f3d8c2f0b9d",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz",
        sha256 = "d94005ae516bb43fc85a07ed89cb51bec96ed931ca5c084427f1432a1dbf71e9",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bookworm_64_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip",
        sha256 = "50f26a9b0ae595bd536f5b7003a465b04871005cbe57c18e84f657e83df13f4c",
        build_file_content = filegroup_all,
    )

    # bullseye-32
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bullseye-2025-arm64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "abf3216fd08968bf3bef67c3cbad720c9dc1385672197a2b2d5f2009a7fd995e",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bullseye-2025-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "d46d8191b8ad04494439bf4d14dc599d8531552e56f25dcd7949dc9cf7b0d512",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bullseye-2025-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "1cfedd017bab157881f5f81b785152033269e02d4fe72e0c36957263d145041b",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-bullseye-2025-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "6d2d6684ffc8791d2a261fb8ed8b92d8c00408f0b24dcd5557ed3aebdd096c15",
        build_file_content = filegroup_all,
    )

    # bullseye-64
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bullseye-2025-arm64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "0f67594b4ea984b6296e838e0f1e8e6efde58916f98b4a650a8b3c391ce18e04",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bullseye-2025-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "d0b581e3962b4d23d720ff982e2df05ba516329b135a6b09e5bf292b114aac2b",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bullseye-2025-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "df3b1fa4ca83d61e853fa32620ede3f2402dc3b6088653c1ae85714cd5c566ed",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_bullseye_64_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/arm64-bullseye-2025-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "d978c2baa757571b3cb413844f3fa26b779259a4f8a680fb2fb872a13c8618b3",
        build_file_content = filegroup_all,
    )

    # raspi-bookworm-32
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bookworm-2025-arm64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "ec754b7d64d3e989dd6dd7a91abab7b4ca9abc5c75f252ab37ffc585ac39a287",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bookworm-2025-x86_64-apple-darwin-Toolchain-12.2.0.tgz",
        sha256 = "9e0db21b655956fea0e9169a9d7daf86ccde1c78bdf42d633305ab8efb944c23",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bookworm-2025-x86_64-linux-gnu-Toolchain-12.2.0.tgz",
        sha256 = "e3cf3a726268aafa55d79af588a1d02392c073a033b8c3b2a0c6ccd99e18a184",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bookworm_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bookworm-2025-x86_64-w64-mingw32-Toolchain-12.2.0.zip",
        sha256 = "dead6a0066885c51b64871d8cd8116919a0cf4040960af1bce0e26290ee4f034",
        build_file_content = filegroup_all,
    )

    # raspi-bullseye-32
    maybe(
        http_archive,
        "bazelrio_raspi_bullseye_32_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bullseye-2025-arm64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "3f30b54ef98aba939058680ba7906b59da758552ee183595dc006613744e0038",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bullseye_32_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bullseye-2025-x86_64-apple-darwin-Toolchain-10.2.0.tgz",
        sha256 = "e205a4824a0d6704e968184e52525c5fa200b3e2278177a80d970b2077896f74",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bullseye_32_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bullseye-2025-x86_64-linux-gnu-Toolchain-10.2.0.tgz",
        sha256 = "b53465a8d36de937a0f88299f8ab3a97db5af3cdf4f7e52473bf294c5c1da3f6",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_raspi_bullseye_32_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/armhf-raspi-bullseye-2025-x86_64-w64-mingw32-Toolchain-10.2.0.zip",
        sha256 = "4a891d7a5de1fc3cd03f60b4340f586ad2750fef8baab35c408e23fa539a0213",
        build_file_content = filegroup_all,
    )

    # roborio
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_macosarm",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/cortexa9_vfpv3-roborio-academic-2025-arm64-apple-darwin-Toolchain-12.1.0.tgz",
        sha256 = "2fb949bf683ac2ecf3874767369c9f6a013941cd9e702f08bd5e4a248e9b82dd",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_macos",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/cortexa9_vfpv3-roborio-academic-2025-x86_64-apple-darwin-Toolchain-12.1.0.tgz",
        sha256 = "5d7021faa2745227adf04ad31f90c64f2b89527dac4283f5a28c0d5c8a227816",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_linux",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/cortexa9_vfpv3-roborio-academic-2025-x86_64-linux-gnu-Toolchain-12.1.0.tgz",
        sha256 = "0ed7c454eab947166c41177f72f795a408f4b7c5fc0f7fd6ee35dba1871fbfac",
        build_file_content = filegroup_all,
    )
    maybe(
        http_archive,
        "bazelrio_roborio_toolchain_windows",
        url = "https://github.com/wpilibsuite/opensdk/releases/download/v2025-1/cortexa9_vfpv3-roborio-academic-2025-x86_64-w64-mingw32-Toolchain-12.1.0.zip",
        sha256 = "1395ae04cf5c617683ff8eb473c949740a6bb57c9405668f179c7206ab6ba3f8",
        build_file_content = filegroup_all,
    )

def setup_legacy_setup_toolchains_dependencies():
    __setup_toolchains_dependencies(None)

deps = module_extension(
    __setup_toolchains_dependencies,
)
