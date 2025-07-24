load("@rules_cc//cc:defs.bzl", "cc_import")
load("@rules_cc//cc/common:cc_shared_library_info.bzl", "CcSharedLibraryInfo")

def _cc_shared_info_adapter_impl(ctx):
    # With versioned symbols, we can't directly build the CcInfo and linker
    # inputs ourselves.  Starlark complains about bad extensions.
    #
    # So, use cc_import to build up both the shared and static versions, and
    # pass on the correct one as needed from this rule.
    static_dep = ctx.attr.static_dep
    static_dep_cc_info = static_dep[CcInfo]

    dynamic_dep = ctx.attr.dynamic_dep
    dynamic_dep_cc_info = dynamic_dep[CcInfo]

    linker_inputs = dynamic_dep_cc_info.linking_context.linker_inputs.to_list()
    if not linker_inputs:
        fail("No linker inputs found in the dependency.")

    if len(linker_inputs) != 1:
        fail("Too many linker inputs found in the dependency.")

    shared_linker_input = linker_inputs[0]

    # Create the CcSharedLibraryInfo provider.
    cc_shared_library_info = CcSharedLibraryInfo(
        linker_input = shared_linker_input,
        # Declare that this shared library exports the symbols of the cc_import target which contains the original static library.
        exports = [str(static_dep.label)],
        dynamic_deps = depset(),
        link_once_static_libs = [str(static_dep.label)],
    )

    runfiles = ctx.runfiles().merge(dynamic_dep[DefaultInfo].default_runfiles)

    return [
        DefaultInfo(
            files = runfiles.files,
            runfiles = runfiles,
        ),
        cc_shared_library_info,
    ]

_cc_shared_info_adapter = rule(
    implementation = _cc_shared_info_adapter_impl,
    attrs = {
        "static_dep": attr.label(
            doc = "The cc_import target to adapt.",
            providers = [CcInfo, DefaultInfo],
            mandatory = True,
        ),
        "dynamic_dep": attr.label(
            doc = "The cc_import target to adapt.",
            providers = [CcInfo, DefaultInfo],
            mandatory = True,
        ),
    },
)

def cc_shared_import(
        name,
        shared_library_file,
        static_library_file,
        hdrs = None,
        includes = None,
        visibility = None,
        target_compatible_with = None):
    """Imports a prebuilt static and shared library such that Bazel will consume it correctly.

    Args:
      shared_library_file: The prebuilt file for the shared library.
      static_library_file: The prebuilt file for the static library.
      hdrs: The headers to export
    """
    interface_library = None
    if shared_library_file.endswith(".dll"):
        interface_library = shared_library_file[:-4] + ".lib"

    # Create a single cc_import with both static and shared libraries, and headers.
    # This target serves as the entry point for static linking.
    # The shared libraries get used in cc_test linking, and the static ones get
    # used for linking cc_binary targets.
    # TODO(austin): pdb files.
    cc_import(
        name = name,
        static_library = static_library_file,
        interface_library = interface_library,
        shared_library = shared_library_file,
        hdrs = hdrs,
        includes = includes,
        visibility = visibility,
        target_compatible_with = target_compatible_with,
    )

    shared_import_name = name + "_shared_import"

    # Now, create the link options for dynamic only linking to be used by the
    # shared library adapter.
    cc_import(
        name = shared_import_name,
        interface_library = interface_library,
        shared_library = shared_library_file,
        hdrs = hdrs,
        includes = includes,
        target_compatible_with = target_compatible_with,
    )

    # Merge the two as expected.
    shared_target_name = name + "_shared"
    _cc_shared_info_adapter(
        name = shared_target_name,
        static_dep = ":" + name,
        dynamic_dep = ":" + shared_import_name,
        visibility = visibility,
        target_compatible_with = target_compatible_with,
    )
