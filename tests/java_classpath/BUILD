load(
    "@io_tweag_rules_haskell//haskell:haskell.bzl",
    "haskell_binary",
)

package(default_testonly = 1)

haskell_binary(
    name = "java_classpath",
    srcs = ["Main.hs"],
    visibility = ["//visibility:public"],
    deps = [
        "@hackage//:base",
        "@hackage//:template-haskell",
        "@org_apache_spark_spark_core_2_10//jar",
    ],
)
