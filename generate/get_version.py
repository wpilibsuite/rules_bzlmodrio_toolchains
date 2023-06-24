from get_toolchain_dependencies import get_toolchain_dependencies


def main():
    toolchain = get_toolchain_dependencies()
    print(toolchain.version)


if __name__ == "__main__":
    main()
