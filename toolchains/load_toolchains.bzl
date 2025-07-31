load("//toolchains:configure_cross_compiler.bzl", "configure_cross_compiler")

def load_toolchains():
    configure_cross_compiler(
        name = "local_bookworm_32",
        bin_subfolder = "bookworm/bin",
        bin_prefix = "armv7-bookworm-linux-gnueabihf-",
        sysroot_subfolder = "bookworm/arm-linux-gnueabihf/sysroot",
        cxx_version = "12",
        target_cpu = "armv7",
        target_system_name = "arm-linux-gnueabihf",
        sysroot_include_folder = "arm-linux-gnueabihf",
        repo_shortname = "bookworm_32",
    )
    configure_cross_compiler(
        name = "local_bookworm_64",
        bin_subfolder = "bookworm/bin",
        bin_prefix = "aarch64-bookworm-linux-gnu-",
        sysroot_subfolder = "bookworm/aarch64-linux-gnu/sysroot",
        cxx_version = "12",
        target_cpu = "armv8a",
        target_system_name = "aarch64-linux-gnu",
        sysroot_include_folder = "aarch64-linux-gnu",
        repo_shortname = "bookworm_64",
    )
    configure_cross_compiler(
        name = "local_raspi_bookworm_32",
        bin_subfolder = "raspi-bookworm/bin",
        bin_prefix = "armv6-bookworm-linux-gnueabihf-",
        sysroot_subfolder = "raspi-bookworm/arm-linux-gnueabihf/sysroot",
        cxx_version = "12",
        target_cpu = "armv7",
        target_system_name = "arm-linux-gnueabihf",
        sysroot_include_folder = "arm-linux-gnueabihf",
        repo_shortname = "raspi_bookworm_32",
    )
    configure_cross_compiler(
        name = "local_roborio",
        bin_subfolder = "roborio-academic/bin",
        bin_prefix = "arm-frc2025-linux-gnueabi-",
        sysroot_subfolder = "roborio-academic/arm-nilrt-linux-gnueabi/sysroot",
        cxx_version = "12",
        target_cpu = "armv7",
        target_system_name = "arm-nilrt-linux-gnueabi",
        sysroot_include_folder = "arm-nilrt-linux-gnueabi",
        repo_shortname = "roborio",
    )
    configure_cross_compiler(
        name = "local_systemcore",
        extra_defines = ["-D__FRC_SYSTEMCORE__=1"],
        bin_subfolder = "bookworm/bin",
        bin_prefix = "aarch64-bookworm-linux-gnu-",
        sysroot_subfolder = "bookworm/aarch64-linux-gnu/sysroot",
        cxx_version = "12",
        target_cpu = "armv8a",
        target_system_name = "aarch64-linux-gnu",
        sysroot_include_folder = "aarch64-linux-gnu",
        repo_shortname = "systemcore",
    )
