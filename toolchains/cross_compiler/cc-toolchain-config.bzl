load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
    "with_feature_set",
)
load("@rules_cc//cc/common:cc_common.bzl", "cc_common")

def _impl(ctx):
    # Alias for readability
    wrapper_extension = ctx.attr.wrapper_extension
    cxx_builtin_include_directories = ctx.attr.cxx_builtin_include_directories

    all_link_actions = [
        ACTION_NAMES.cpp_link_executable,
        ACTION_NAMES.cpp_link_dynamic_library,
        ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ]

    lto_index_actions = [
        ACTION_NAMES.lto_index_for_executable,
        ACTION_NAMES.lto_index_for_dynamic_library,
        ACTION_NAMES.lto_index_for_nodeps_dynamic_library,
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

    # TODO(austin): Turn this on when the new toolchain is released.
    use_gold = False

    tool_paths = [
        tool_path(name = "gcc", path = "bin/gcc" + wrapper_extension),
        tool_path(name = "ld", path = "bin/ld.gold" + wrapper_extension if use_gold else "bin/ld" + wrapper_extension),
        tool_path(name = "ar", path = "bin/ar" + wrapper_extension),
        tool_path(name = "cpp", path = "bin/cpp" + wrapper_extension),
        tool_path(name = "gcov", path = "bin/gcov" + wrapper_extension),
        tool_path(name = "nm", path = "bin/nm" + wrapper_extension),
        tool_path(name = "objdump", path = "bin/objdump" + wrapper_extension),
        tool_path(name = "strip", path = "bin/strip" + wrapper_extension),
        tool_path(name = "dwp", path = "bin/dwp" + wrapper_extension),
        tool_path(name = "objcopy", path = "bin/objcopy" + wrapper_extension),
    ]

    objcopy_action = action_config(
        action_name = ACTION_NAMES.objcopy_embed_data,
        tools = [
            tool(
                path = "bin/objcopy" + wrapper_extension,
            ),
        ],
    )
    action_configs = [objcopy_action]

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
                        ] + ctx.attr.extra_defines,
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
                actions = all_link_actions + lto_index_actions,
                flag_groups = ([
                    flag_group(
                        flags = ([
                            # Enables --start-lib
                            "-fuse-ld=gold",
                        ] if use_gold else []) + [
                            "-pthread",
                            "-latomic",
                            "-lstdc++",
                            "-lm",
                            "-fno-canonical-system-headers",
                            "-rdynamic",
                            "-ldl",
                            "-Wl,-rpath,'$ORIGIN'",
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
                        # Security hardening requires optimization.
                        # We need to undef it as some distributions now have it enabled by default.
                        flags = ["-U_FORTIFY_SOURCE"],
                    ),
                ],
                with_features = [
                    with_feature_set(
                        not_features = ["thin_lto"],
                    ),
                ],
            ),
            flag_set(
                actions = all_compile_actions,
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-Wformat=2",
                            "-pedantic",
                            "-Wno-psabi",
                            "-Wno-unused-parameter",
                            "-pthread",
                            "-fstack-protector",
                            "-Wall",
                            "-fno-omit-frame-pointer",
                            "-Wextra",
                        ],
                    ),
                ]),
            ),
            flag_set(
                actions = all_compile_actions,
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-g",
                            "-Og",
                            "-g",
                            "-gz=zlib",
                            "-ffunction-sections",
                            "-fdata-sections",
                        ],
                    ),
                ]),
                with_features = [with_feature_set(features = ["dbg"])],
            ),
            flag_set(
                actions = all_compile_actions,
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-g0",
                            "-O2",
                            "-D_FORTIFY_SOURCE=1",
                            "-DNDEBUG",
                            "-ffunction-sections",
                            "-fdata-sections",
                        ],
                    ),
                ]),
                with_features = [with_feature_set(features = ["opt"])],
            ),
            flag_set(
                actions = [ACTION_NAMES.c_compile],
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-Wformat=2",
                            "-pedantic",
                            "-Wno-psabi",
                            "-Wno-unused-parameter",
                            "-fPIC",
                            "-pthread",
                        ],
                    ),
                ]),
            ),
            flag_set(
                actions = all_cpp_compile_actions + [ACTION_NAMES.lto_backend],
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-std=c++20",
                            "-Wno-error=deprecated-declarations",
                            "-Wno-deprecated-enum-enum-conversion",
                            "-Wformat=2",
                            "-pedantic",
                            "-Wno-psabi",
                            "-Wno-unused-parameter",
                            "-fPIC",
                            "-pthread",
                        ],
                    ),
                ]),
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
        enabled = True,
    )

    treat_warnings_as_errors_feature = feature(
        name = "treat_warnings_as_errors",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = ["-Werror"])],
            ),
            flag_set(
                actions = all_link_actions,
                flag_groups = [flag_group(
                    flags = ["-Wl,-fatal-warnings"],
                )],
            ),
        ],
    )

    archive_param_file_feature = feature(
        name = "archive_param_file",
        enabled = True,
    )

    supports_pic_feature = feature(
        name = "supports_pic",
        enabled = True,
    )

    features = []
    if use_gold:
        supports_start_end_lib_feature = feature(
            name = "supports_start_end_lib",
            enabled = True,
        )
        features.append(supports_start_end_lib_feature)

    gcc_quoting_for_param_files_feature = feature(
        name = "gcc_quoting_for_param_files",
        enabled = True,
    )

    static_link_cpp_runtimes_feature = feature(
        name = "static_link_cpp_runtimes",
        enabled = False,
    )

    dbg_feature = feature(name = "dbg")

    opt_feature = feature(name = "opt")

    set_install_name_feature = feature(
        name = "set_soname",
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.cpp_link_dynamic_library,
                    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-Wl,-soname,%{runtime_solib_name}",
                        ],
                        expand_if_available = "runtime_solib_name",
                    ),
                ],
            ),
        ],
    )

    features += [
        unfiltered_compile_flags_feature,
        default_link_flags_feature,
        default_compile_flags_feature,
        treat_warnings_as_errors_feature,
        sysroot_feature,
        dbg_feature,
        opt_feature,
        compiler_param_feature,
        supports_pic_feature,
        gcc_quoting_for_param_files_feature,
        static_link_cpp_runtimes_feature,
        archive_param_file_feature,
        set_install_name_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        action_configs = action_configs,
        toolchain_identifier = ctx.attr.toolchain_identifier,
        host_system_name = "local",
        target_system_name = ctx.attr.target_system_name,
        target_cpu = ctx.attr.target_cpu,
        target_libc = "glibc-2.24",
        cc_target_os = "linux",
        compiler = "gcc",
        abi_version = "gcc-12.1.0",
        abi_libc_version = "glibc-2.24",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
    )

cc_toolchain_config = rule(
    attrs = {
        "cxx_builtin_include_directories": attr.string_list(mandatory = True),
        "extra_defines": attr.string_list(),
        "target_cpu": attr.string(mandatory = True),
        "target_system_name": attr.string(mandatory = True),
        "toolchain_identifier": attr.string(mandatory = True),
        "wrapper_extension": attr.string(mandatory = True),
    },
    provides = [CcToolchainConfigInfo],
    implementation = _impl,
)
