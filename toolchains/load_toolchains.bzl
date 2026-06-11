load("//toolchains:configure_cross_compiler.bzl", "configure_cross_compiler")

def load_toolchains():
    configure_cross_compiler(
        name = "local_trixie64",
        bin_subfolder = "trixie/bin",
        bin_prefix = "aarch64-trixie-linux-gnu-",
        sysroot_subfolder = "trixie/aarch64-linux-gnu/sysroot",
        cxx_version = "14",
        target_cpu = "armv8a",
        target_system_name = "aarch64-linux-gnu",
        sysroot_include_folder = "aarch64-linux-gnu",
        repo_shortname = "trixie64",
    )
    configure_cross_compiler(
        name = "local_systemcore",
        extra_defines = ["-D__FIRST_SYSTEMCORE__=1"],
        bin_subfolder = "systemcore/bin",
        bin_prefix = "aarch64-systemcore2027-linux-gnu-",
        sysroot_subfolder = "systemcore/aarch64-linux-gnu/sysroot",
        cxx_version = "14",
        target_cpu = "armv8a",
        target_system_name = "aarch64-linux-gnu",
        sysroot_include_folder = "aarch64-linux-gnu",
        repo_shortname = "systemcore",
    )
    configure_cross_compiler(
        name = "local_systemcore_debug",
        extra_defines = ["-D__FIRST_SYSTEMCORE__=1"],
        bin_subfolder = "systemcore/bin",
        bin_prefix = "aarch64-systemcore2027-linux-gnu-",
        sysroot_subfolder = "systemcore/aarch64-linux-gnu/sysroot",
        cxx_version = "14",
        target_cpu = "armv8a",
        target_system_name = "aarch64-linux-gnu",
        sysroot_include_folder = "aarch64-linux-gnu",
        repo_shortname = "systemcore_debug",
    )
