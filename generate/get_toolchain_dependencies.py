import sys
import os

from bazelrio_gentool.deps.cpp_toolchain_dependency import (
    CppToolchainConfig,
    CppPlatformConfig,
    ToolchainDependencyContainer,
)


def get_toolchain_dependencies():
    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/arm64-bullseye-2023-x86_64-apple-darwin-Toolchain-10.2.0.tgz
    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academic-2023-aarch64-bullseye-linux-gnu-Toolchain-12.1.0.tgz
    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academic-2023-x86_64-apple-darwin-Toolchain-12.1.0.tgz
    # https://github.com/wpilibsuite/opensdk/releases/download/v2023-7/cortexa9_vfpv3-roborio-academi-2023-aarch64-apple-darwin-Toolchain-12.1.0.tgz
    toolchains = [
        ("arm64-bullseye", "bullseye-64", "10.2.0"),
        ("armhf-bullseye", "bullseye-32", "10.2.0"),
        ("armhf-raspi-bullseye", "raspi-32", "10.2.0"),
        ("cortexa9_vfpv3-roborio-academic", "roborio", "12.1.0"),
    ]

    overall_year = "2023"
    overall_version = "7"

    container = ToolchainDependencyContainer(
        "rules_bzlmodrio_toolchains", overall_year, overall_year + "-" + overall_version
    )

    for name, short_name, version in toolchains:
        config = CppToolchainConfig(
            year=overall_year,
            release_version=f"{overall_year}_{overall_version}",
            repo_name="rules_bullseye_toolchain",
            short_name=short_name,
            version=f"{overall_year}-{overall_version}",
            cpp_platform_configs=[
                # CppPlatformConfig("macos", "apple-darwin", ".tgz", "arm64"),
                CppPlatformConfig("macos", "apple-darwin", ".tgz", "x86_64"),
                CppPlatformConfig("linux", "linux-gnu", ".tgz", "x86_64"),
                CppPlatformConfig("windows", "w64-mingw32", ".zip", "x86_64"),
            ],
            toolchain_version=version,
            cpp_url="https://github.com/wpilibsuite/opensdk/releases/download/v{release_version_hyphen}/"
            + name
            + "-{year}-{arch}-{platform_config.short_os}-Toolchain-{toolchain_version}{platform_config.ext}",
        )
        container.configs.append(config)

    container.configs = sorted(container.configs, key=lambda x: x.short_name)

    return container
