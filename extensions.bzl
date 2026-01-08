load("//toolchains:load_toolchains.bzl", "load_toolchains")

def _cfg_impl(ctx):
    load_toolchains()

cfg = module_extension(implementation = _cfg_impl)
