def __helper(is_roborio, is_raspi):
    defines = []

    defines.append("IS_ROBORIO_TEST=" + ("1" if is_roborio else "0"))
    defines.append("IS_RASPBIAN_TEST=" + ("1" if is_raspi else "0"))

    return defines

def defines_helper():
    output = {
        "@wpilib_toolchains//constraints/is_roborio:roborio": __helper(is_roborio = True, is_raspi = False),
        "@wpilib_toolchains//constraints/is_rpbookworm32:rpbookworm32": __helper(is_roborio = False, is_raspi = True),
        "//conditions:default": __helper(is_roborio = False, is_raspi = False),
    }

    return output
