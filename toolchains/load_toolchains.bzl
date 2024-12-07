load("//toolchains:configure_cross_compiler.bzl", "configure_cross_compiler")

def load_toolchains():
    configure_cross_compiler(
        name = "local_bookworm_32",
        compiler = "bookworm-32",
        bin_subfolder = "bookworm/bin",
        bin_prefix = "armv7-bookworm-linux-gnueabihf-",
        sysroot_subfolder = "bookworm/arm-linux-gnueabihf/sysroot",
        cxx_version = "12",
        sysroot_include_folder = "arm-linux-gnueabihf",
        repo_shortname = "bookworm_32",
    )
    configure_cross_compiler(
        name = "local_bookworm_64",
        compiler = "bookworm-64",
        bin_subfolder = "bookworm/bin",
        bin_prefix = "aarch64-bookworm-linux-gnu-",
        sysroot_subfolder = "bookworm/aarch64-linux-gnu/sysroot",
        cxx_version = "12",
        sysroot_include_folder = "aarch64-linux-gnu",
        repo_shortname = "bookworm_64",
    )
    configure_cross_compiler(
        name = "local_bullseye_32",
        compiler = "bullseye-32",
        bin_subfolder = "bullseye/bin",
        bin_prefix = "armv7-bullseye-linux-gnueabihf-",
        sysroot_subfolder = "bullseye/arm-linux-gnueabihf/sysroot",
        cxx_version = "10",
        sysroot_include_folder = "arm-linux-gnueabihf",
        repo_shortname = "bullseye_32",
    )
    configure_cross_compiler(
        name = "local_bullseye_64",
        compiler = "bullseye-64",
        bin_subfolder = "bullseye/bin",
        bin_prefix = "aarch64-bullseye-linux-gnu-",
        sysroot_subfolder = "bullseye/aarch64-linux-gnu/sysroot",
        cxx_version = "10",
        sysroot_include_folder = "aarch64-linux-gnu",
        repo_shortname = "bullseye_64",
    )
    configure_cross_compiler(
        name = "local_raspi_bookworm_32",
        compiler = "raspi-bookworm-32",
        bin_subfolder = "raspi-bookworm/bin",
        bin_prefix = "armv6-bookworm-linux-gnueabihf-",
        sysroot_subfolder = "raspi-bookworm/arm-linux-gnueabihf/sysroot",
        cxx_version = "12",
        sysroot_include_folder = "arm-linux-gnueabihf",
        repo_shortname = "raspi_bookworm_32",
    )
    configure_cross_compiler(
        name = "local_raspi_bullseye_32",
        compiler = "raspi-bullseye-32",
        bin_subfolder = "raspi-bullseye/bin",
        bin_prefix = "armv6-bullseye-linux-gnueabihf-",
        sysroot_subfolder = "raspi-bullseye/arm-linux-gnueabihf/sysroot",
        cxx_version = "10",
        sysroot_include_folder = "arm-linux-gnueabihf",
        repo_shortname = "raspi_bullseye_32",
    )
    configure_cross_compiler(
        name = "local_roborio",
        compiler = "roborio",
        bin_subfolder = "roborio-academic/bin",
        bin_prefix = "arm-frc2025-linux-gnueabi-",
        sysroot_subfolder = "roborio-academic/arm-nilrt-linux-gnueabi/sysroot",
        cxx_version = "12",
        sysroot_include_folder = "arm-nilrt-linux-gnueabi",
        repo_shortname = "roborio",
    )
