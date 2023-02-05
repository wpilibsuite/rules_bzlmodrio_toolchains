load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

def _impl(ctx):
    # Alias for readability
    wrapper_extension = ctx.attr.wrapper_extension
    cxx_builtin_include_directories = ctx.attr.cxx_builtin_include_directories

    all_link_actions = [
        ACTION_NAMES.cpp_link_executable,
        ACTION_NAMES.cpp_link_dynamic_library,
        ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ]

    all_compile_actions = [
        ACTION_NAMES.c_compile,
        ACTION_NAMES.cpp_compile,
        ACTION_NAMES.linkstamp_compile,
        ACTION_NAMES.assemble,
        ACTION_NAMES.preprocess_assemble,
        ACTION_NAMES.cpp_header_parsing,
        ACTION_NAMES.cpp_module_compile,
        ACTION_NAMES.cpp_module_codegen,
        ACTION_NAMES.clif_match,
        ACTION_NAMES.lto_backend,
    ]

    all_cpp_compile_actions = [
        ACTION_NAMES.cpp_compile,
        ACTION_NAMES.linkstamp_compile,
        ACTION_NAMES.cpp_header_parsing,
        ACTION_NAMES.cpp_module_compile,
        ACTION_NAMES.cpp_module_codegen,
        ACTION_NAMES.clif_match,
    ]

    tool_paths = [
        tool_path(name = "gcc", path = "bin/gcc" + wrapper_extension),
        tool_path(name = "ld", path = "bin/ld" + wrapper_extension),
        tool_path(name = "ar", path = "bin/ar" + wrapper_extension),
        tool_path(name = "cpp", path = "bin/cpp" + wrapper_extension),
        tool_path(name = "gcov", path = "bin/gcov" + wrapper_extension),
        tool_path(name = "nm", path = "bin/nm" + wrapper_extension),
        tool_path(name = "objdump", path = "bin/objdump" + wrapper_extension),
        tool_path(name = "strip", path = "bin/strip" + wrapper_extension),
    ]

    unfiltered_compile_flags_feature = feature(
        name = "unfiltered_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            # Do not resolve our smylinked resource prefixes to real paths.
                            "-fno-canonical-system-headers",
                            # Reproducibility
                            "-Wno-builtin-macro-redefined",
                            "-D__DATE__=\"redacted\"",
                            "-D__TIMESTAMP__=\"redacted\"",
                            "-D__TIME__=\"redacted\"",
                        ],
                    ),
                ],
            ),
        ],
    )

    default_link_flags_feature = feature(
        name = "default_link_flags_feature",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-rdynamic",
                            "-pthread",
                            "-ldl",
                            "-latomic",
                            "-lstdc++",
                            "-lm",
                            "-fno-canonical-system-headers",
                        ],
                    ),
                ]),
            ),
        ],
    )

    default_compile_flags_feature = feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-Wformat=2",
                            "-pedantic",
                            "-Wno-psabi",
                            "-Wno-unused-parameter",
                            "-fPIC",
                            "-rdynamic",
                            "-pthread",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = all_cpp_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-lstdc++",
                        ],
                    ),
                ],
            ),
        ],
    )

    system_include_flags = []
    for d in cxx_builtin_include_directories:
        system_include_flags.extend(["-isystem", d])

    sysroot_feature = feature(
        name = "sysroot",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = system_include_flags,
                    ),
                ],
            ),
        ],
    )

    compiler_param_feature = feature(
        name = "compiler_param_file",
    )

    features = [
        unfiltered_compile_flags_feature,
        default_link_flags_feature,
        default_compile_flags_feature,
        sysroot_feature,
        compiler_param_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        toolchain_identifier = ctx.attr.toolchain_identifier,
        host_system_name = "local",
        target_system_name = "arm-frc2023-linux-gnueabi",
        target_cpu = "armv7",
        target_libc = "glibc-2.24",
        cc_target_os = "linux",
        compiler = "gcc-12.1.0",
        abi_version = "gcc-12.1.0",
        abi_libc_version = "glibc-2.24",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        # builtin_sysroot = ctx.attr.builtin_sysroot,
    )

cc_toolchain_config = rule(
    attrs = {
        "toolchain_identifier": attr.string(mandatory = True),
        "wrapper_extension": attr.string(mandatory = True),
        "cxx_builtin_include_directories": attr.string_list(mandatory = True),
    },
    provides = [CcToolchainConfigInfo],
    implementation = _impl,
)
