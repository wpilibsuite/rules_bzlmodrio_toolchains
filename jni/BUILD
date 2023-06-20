load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "embedded_jni_header",
    hdrs = ["arm-linux-jni/jni.h"],
    includes = ["arm-linux-jni"],
    strip_include_prefix = "arm-linux-jni",
)

cc_library(
    name = "embedded_jni_md_header",
    hdrs = ["arm-linux-jni/linux/jni_md.h"],
    includes = ["arm-linux-jni/linux"],
    strip_include_prefix = "arm-linux-jni/linux",
)

cc_library(
    name = "bzlmodrio_toolchain_jni",
    deps = [
        ":embedded_jni_header",
        ":embedded_jni_md_header",
    ],
)

cc_library(
    name = "jni",
    visibility = ["//visibility:public"],
    deps = select({
        "@bazel_tools//src/conditions:darwin": ["@bazel_tools//tools/jdk:jni"],
        "@bazel_tools//src/conditions:linux_x86_64": ["@bazel_tools//tools/jdk:jni"],
        "@bazel_tools//src/conditions:windows": ["@bazel_tools//tools/jdk:jni"],
        "@rules_bzlmodrio_toolchains//constraints/combined:is_cross_compiler": [":bzlmodrio_toolchain_jni"],
    }),
)
