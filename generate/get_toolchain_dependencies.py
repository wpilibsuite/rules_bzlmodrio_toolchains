from typing import NamedTuple

from bazelrio_gentool.deps.cpp_toolchain_dependency import (
    CppToolchainConfig,
    CppPlatformConfig,
    ToolchainDependencyContainer,
)


class ToolchainDef(NamedTuple):
    name: str
    short_name: str
    bin_subfolder: str
    bin_prefix: str
    sysroot_subfolder: str
    cxx_version: str
    sysroot_include_folder: str
    toolchain_version: str


def get_toolchain_dependencies():
    overall_year = "2024"
    overall_version = "1"

    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/arm64-bullseye-2023-x86_64-apple-darwin-Toolchain-10.2.0.tgz
    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academic-2023-aarch64-bullseye-linux-gnu-Toolchain-12.1.0.tgz
    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academic-2023-x86_64-apple-darwin-Toolchain-12.1.0.tgz
    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academi-2023-aarch64-apple-darwin-Toolchain-12.1.0.tgz
    toolchains = [
        ToolchainDef(
            name="armhf-bullseye",
            short_name="bullseye-32",
            bin_subfolder="bullseye/bin",
            bin_prefix="armv7-bullseye-linux-gnueabihf-",
            sysroot_subfolder="bullseye/arm-linux-gnueabihf/sysroot",
            cxx_version="10",
            sysroot_include_folder="arm-linux-gnueabihf",
            toolchain_version="10.2.0",
        ),
        ToolchainDef(
            name="arm64-bullseye",
            short_name="bullseye-64",
            bin_subfolder="bullseye/bin",
            bin_prefix="aarch64-bullseye-linux-gnu-",
            sysroot_subfolder="bullseye/aarch64-linux-gnu/sysroot",
            cxx_version="10",
            sysroot_include_folder="aarch64-linux-gnu",
            toolchain_version="10.2.0",
        ),
        ToolchainDef(
            name="armhf-raspi-bullseye",
            short_name="raspi-32",
            bin_subfolder="raspi-bullseye/bin",
            bin_prefix="armv6-bullseye-linux-gnueabihf-",
            sysroot_subfolder="raspi-bullseye/arm-linux-gnueabihf/sysroot",
            cxx_version="10",
            sysroot_include_folder="arm-linux-gnueabihf",
            toolchain_version="10.2.0",
        ),
        ToolchainDef(
            name="cortexa9_vfpv3-roborio-academic",
            short_name="roborio",
            bin_subfolder="roborio-academic/bin",
            bin_prefix="arm-frc" + overall_year + "-linux-gnueabi-",
            sysroot_subfolder="roborio-academic/arm-nilrt-linux-gnueabi/sysroot",
            cxx_version="12",
            sysroot_include_folder="arm-nilrt-linux-gnueabi",
            toolchain_version="12.1.0",
        ),
    ]

    container = ToolchainDependencyContainer(
        "rules_bzlmodrio_toolchains", overall_year, overall_year + "-" + overall_version
    )

    for toolchain_info in toolchains:
        info_as_dict = toolchain_info._asdict()
        del info_as_dict["name"]
        config = CppToolchainConfig(
            year=overall_year,
            release_version=f"{overall_year}_{overall_version}",
            repo_name="rules_bullseye_toolchain",
            version=f"{overall_year}-{overall_version}",
            cpp_platform_configs=[
                # CppPlatformConfig("macos", "apple-darwin", ".tgz", "arm64"),
                CppPlatformConfig("macos", "apple-darwin", ".tgz", "x86_64"),
                CppPlatformConfig("linux", "linux-gnu", ".tgz", "x86_64"),
                CppPlatformConfig("windows", "w64-mingw32", ".zip", "x86_64"),
            ],
            cpp_url="https://github.com/wpilibsuite/opensdk/releases/download/v{release_version_hyphen}/"
            + toolchain_info.name
            + "-{year}-{arch}-{platform_config.short_os}-Toolchain-{toolchain_version}{platform_config.ext}",
            **info_as_dict,
        )
        container.configs.append(config)

    container.configs = sorted(container.configs, key=lambda x: x.short_name)

    return container
