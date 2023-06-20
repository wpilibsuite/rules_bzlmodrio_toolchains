def __helper(is_roborio, is_bullseye, is_raspi):
    defines = []

    defines.append("IS_ROBORIO_TEST=" + ("1" if is_roborio else "0"))
    defines.append("IS_BULLSEYE_TEST=" + ("1" if is_bullseye else "0"))
    defines.append("IS_RASPBIAN_TEST=" + ("1" if is_raspi else "0"))

    return defines

def defines_helper():
    output = {
        "@rules_bzlmodrio_toolchains//constraints/is_bullseye32:bullseye32": __helper(is_roborio = False, is_bullseye = True, is_raspi = False),
        "@rules_bzlmodrio_toolchains//constraints/is_bullseye64:bullseye64": __helper(is_roborio = False, is_bullseye = True, is_raspi = False),
        "@rules_bzlmodrio_toolchains//constraints/is_raspi32:raspi32": __helper(is_roborio = False, is_bullseye = False, is_raspi = True),
        "@rules_bzlmodrio_toolchains//constraints/is_roborio:roborio": __helper(is_roborio = True, is_bullseye = False, is_raspi = False),
        "//conditions:default": __helper(is_roborio = False, is_bullseye = False, is_raspi = False),
    }

    return output
