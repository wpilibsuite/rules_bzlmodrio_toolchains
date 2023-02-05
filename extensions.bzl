load("//toolchains:load_toolchains.bzl", "load_toolchains")

def _sh_configure_impl(ctx):
    load_toolchains()

sh_configure = module_extension(implementation = _sh_configure_impl)
