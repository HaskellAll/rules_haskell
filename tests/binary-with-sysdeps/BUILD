load(
    "@io_tweag_rules_haskell//haskell:haskell.bzl",
    "haskell_binary",
    "haskell_cc_import",
)

package(default_testonly = 1)

haskell_cc_import(
    name = "zlib",
    shared_library = "@zlib//:lib",
)

haskell_binary(
    name = "binary-with-sysdeps",
    srcs = ["Main.hs"],
    visibility = ["//visibility:public"],
    deps = [
        ":zlib",
        "@hackage//:base",
    ],
)
