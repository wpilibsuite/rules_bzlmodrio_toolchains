def defines_helper():
    return {
        "@wpilib_toolchains//constraints/is_systemcore:systemcore": ["IS_SYSTEMCORE_TEST=1"],
        "@wpilib_toolchains//constraints/is_systemcore_debug:systemcore_debug": ["IS_SYSTEMCORE_TEST=1"],
        "//conditions:default": ["IS_SYSTEMCORE_TEST=0"],
    }
