load(":cc-toolchain-config.bzl", "cc_toolchain_config")
tag = "{target_cpu}"

cc_toolchain_config_name = "cc-toolchain_config-{}".format(tag)

compiler_files_name = "compiler_files-{}".format(tag)
cc_toolchain_name = "cc-compiler-{}".format(tag)
toolchain_name = "cc-toolchain-{}".format(tag)

sysroot_everything = "@{}//:all".format("{compiler_repo}")

cxx_builtin_include_directories = [
        "external/{actual_compiler_path}/{sysroot}/usr/lib/gcc/{sysroot_include_folder}/{cxx_version}/include",
        "external/{actual_compiler_path}/{sysroot}/usr/lib/gcc/{sysroot_include_folder}/{cxx_version}/include-fixed",
        "external/{actual_compiler_path}/{sysroot}/usr/include/{sysroot_include_folder}/c++/{cxx_version}",
        "external/{actual_compiler_path}/{sysroot}/usr/include/c++/{cxx_version}",
        "external/{actual_compiler_path}/{sysroot}/usr/include/c++/{cxx_version}/{sysroot_include_folder}",
        "external/{actual_compiler_path}/{sysroot}/usr/include/c++/{cxx_version}/backward",
        "external/{actual_compiler_path}/{sysroot}/usr/include/{sysroot_include_folder}",
        "external/{actual_compiler_path}/{sysroot}/usr/include",
]

cc_toolchain_config(
    name = cc_toolchain_config_name,
    toolchain_identifier = toolchain_name,
    wrapper_extension = "{wrapper_extension}",
    target_cpu = "{target_cpu}",
    target_system_name = "{target_system_name}",
    cxx_builtin_include_directories=cxx_builtin_include_directories
)

filegroup(
    name = compiler_files_name,
    srcs = glob(["bin/**"]) + [
        sysroot_everything
    ] ,
)

cc_toolchain(
    name = cc_toolchain_name,
    all_files = compiler_files_name,
    ar_files = compiler_files_name,
    as_files = compiler_files_name,
    compiler_files = compiler_files_name,
    dwp_files = compiler_files_name,
    linker_files = compiler_files_name,
    objcopy_files = compiler_files_name,
    strip_files = compiler_files_name,
    toolchain_config = cc_toolchain_config_name,
)

toolchain(
    name = "windows",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
    ],
    target_compatible_with = ["@rules_bzlmodrio_toolchains//constraints/is_{repo_short_name_no_dash}:true"],
    toolchain = cc_toolchain_name,
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "linux",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = ["@rules_bzlmodrio_toolchains//constraints/is_{repo_short_name_no_dash}:true"],
    toolchain = cc_toolchain_name,
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "macos",
    exec_compatible_with = [
        # assuming x86/ARM Macs use the same x86 WPILib toolchain
        "@platforms//os:osx",
    ],
    target_compatible_with = ["@rules_bzlmodrio_toolchains//constraints/is_{repo_short_name_no_dash}:true"],
    toolchain = cc_toolchain_name,
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cc_toolchain_suite(
    name = "compiler",
    toolchains = {
        "roborio": cc_toolchain_name,
    },
    tags = ["manual"],
)
