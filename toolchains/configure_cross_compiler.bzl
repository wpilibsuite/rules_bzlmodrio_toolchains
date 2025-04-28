def configure_cross_compiler_impl(repository_ctx):
    compiler_name = repository_ctx.attr.compiler

    substitutions = {
        "{arg_passthrough}": '"$@"',
        "{bin_subfolder}": repository_ctx.attr.bin_subfolder,
        "{binary_prefix}": repository_ctx.attr.bin_prefix,
        "{command_prefix}": "",
        "{compiler}": compiler_name,
        "{cxx_version}": repository_ctx.attr.cxx_version,
        "{exe_suffix}": "",
        "{repo_short_name_no_dash}": repository_ctx.attr.repo_shortname.replace("_", ""),
        "{repo_short_name}": repository_ctx.attr.repo_shortname,
        "{sep}": "/",
        "{sysroot_include_folder}": repository_ctx.attr.sysroot_include_folder,
        "{sysroot}": repository_ctx.attr.sysroot_subfolder,
        "{tool_platform_suffix}": "",
        "{wrapper_extension}": "",
    }

    if repository_ctx.os.name.startswith("windows"):
        substitutions["{command_prefix}"] = "@echo off\n"
        substitutions["{tool_platform_suffix}"] = ".exe"
        substitutions["{compiler_repo}"] = "bazelrio_{}_toolchain_windows".format(repository_ctx.attr.repo_shortname)
        substitutions["{sep}"] = "\\"
        substitutions["{bin_subfolder}"] = substitutions["{bin_subfolder}"].replace("/", "\\")

        substitutions["{arg_passthrough}"] = "%*"
        substitutions["{wrapper_extension}"] = ".bat"
    elif repository_ctx.os.name == "mac os x":
        substitutions["{compiler_repo}"] = "bazelrio_{}_toolchain_macos".format(repository_ctx.attr.repo_shortname)
    elif repository_ctx.os.name == "linux":
        substitutions["{compiler_repo}"] = "bazelrio_{}_toolchain_linux".format(repository_ctx.attr.repo_shortname)
    else:
        fail("Unknown os " + repository_ctx.os.name)

    BINARIES = [
        "ar",
        "cpp",
        "gcc",
        "gcov",
        "ld",
        "nm",
        "objdump",
        "strip",
    ]

    compiler_workspace = Label("@" + substitutions["{compiler_repo}"]).workspace_name
    substitutions["{actual_compiler_path}"] = compiler_workspace
    substitutions["{target_cpu}"] = repository_ctx.attr.target_cpu
    substitutions["{target_system_name}"] = repository_ctx.attr.target_system_name

    for binary in BINARIES:
        bin_substitution = dict(substitutions)
        bin_substitution["{binary_target}"] = binary
        bin_substitution["{compiler_workspace}"] = compiler_workspace
        repository_ctx.template(
            "bin/" + binary + substitutions["{wrapper_extension}"],
            repository_ctx.path(Label("@rules_bzlmodrio_toolchains//toolchains/cross_compiler:command_wrapper.tpl")),
            substitutions = bin_substitution,
        )

    repository_ctx.template(
        "BUILD.bazel",
        repository_ctx.path(Label("@rules_bzlmodrio_toolchains//toolchains/cross_compiler:BUILD.tpl")),
        substitutions = substitutions,
    )

    repository_ctx.template(
        "cc-toolchain-config.bzl",
        repository_ctx.path(Label("@rules_bzlmodrio_toolchains//toolchains/cross_compiler:cc-toolchain-config.bzl")),
        substitutions = substitutions,
    )

configure_cross_compiler = repository_rule(
    implementation = configure_cross_compiler_impl,
    configure = True,
    attrs = {
        "bin_prefix": attr.string(mandatory = True),
        "bin_subfolder": attr.string(mandatory = True),
        "compiler": attr.string(mandatory = True),
        "cxx_version": attr.string(mandatory = True),
        "repo_shortname": attr.string(mandatory = True),
        "sysroot_include_folder": attr.string(mandatory = True),
        "sysroot_subfolder": attr.string(mandatory = True),
        "target_cpu": attr.string(mandatory = True),
        "target_system_name": attr.string(mandatory = True),
    },
)
