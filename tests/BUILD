load(":sh_inline_test.bzl", "sh_inline_test")
load("@bazel_tools//tools/build_rules:test_rules.bzl", "rule_test")
load(
    "@io_tweag_rules_haskell//haskell:haskell.bzl",
    "haskell_binary",
    "haskell_doctest_toolchain",
    "haskell_proto_toolchain",
    "haskell_toolchain",
)

package(default_testonly = 1)

ghc_version = "8.4.4"

haskell_toolchain(
    name = "ghc",
    # This toolchain is morally testonly.  However, that would break
    # our tests of haskell_library_rules: aspects of non-testonly
    # proto_library rules (from com_google_protobuf) can't themselves
    # be testonly.
    testonly = 0,
    c2hs = "@hackage-c2hs//:bin",
    compiler_flags = [
        "-XStandaloneDeriving",  # Flag used at compile time
        "-threaded",  # Flag used at link time

        # Used by `tests/repl-flags`
        "-DTESTS_TOOLCHAIN_COMPILER_FLAGS",
        "-XNoOverloadedStrings",  # this is the default, so it does not harm other tests
    ],
    haddock_flags = ["-U"],
    locale_archive = select({
        # For some reason glibcLocales is not available on Darwin.
        "@bazel_tools//src/conditions:darwin": None,
        "//conditions:default": "@glib_locales//:locale-archive",
    }),
    repl_ghci_args = [
        # Used by `tests/repl-flags`
        "-UTESTS_TOOLCHAIN_REPL_FLAGS",  # The repl test will need this flag, but set by the local `repl_ghci_args`.
        "-XOverloadedStrings",  # The repl test will need OverloadedString
    ],
    tools = "@hackage-ghc//:bin",
    version = ghc_version,
)

haskell_doctest_toolchain(
    name = "doctest-toolchain",
    doctest = "@hackage-doctest//:bin",
)

haskell_proto_toolchain(
    name = "protobuf-toolchain",
    testonly = 0,
    plugin = "@hackage-proto-lens-protoc//:bin/proto-lens-protoc",
    protoc = "@com_google_protobuf//:protoc",
    deps = [
        "@hackage//:base",
        "@hackage//:bytestring",
        "@hackage//:containers",
        "@hackage//:data-default-class",
        "@hackage//:lens-family",
        "@hackage//:lens-family-core",
        "@hackage//:lens-labels",
        "@hackage//:mtl",
        "@hackage//:proto-lens",
        "@hackage//:text",
    ],
)

rule_test(
    name = "test-binary-simple",
    size = "small",
    generates = ["binary-simple"],
    rule = "//tests/binary-simple",
)

rule_test(
    name = "test-binary-custom-main",
    size = "small",
    generates = ["binary-custom-main"],
    rule = "//tests/binary-custom-main",
)

rule_test(
    name = "test-binary-with-lib",
    size = "small",
    generates = ["binary-with-lib"],
    rule = "//tests/binary-with-lib",
)

rule_test(
    name = "test-binary-with-prebuilt",
    size = "small",
    generates = ["binary-with-prebuilt"],
    rule = "//tests/binary-with-prebuilt",
)

rule_test(
    name = "test-binary-with-main",
    size = "small",
    generates = ["binary-with-main"],
    rule = "//tests/binary-with-main",
)

rule_test(
    name = "test-binary-with-sysdeps",
    size = "small",
    generates = ["binary-with-sysdeps"],
    rule = "//tests/binary-with-sysdeps",
)

sh_test(
    name = "test-binary-with-data",
    size = "small",
    srcs = ["//tests/binary-with-data"],
    args = ["$(location //tests/binary-with-data:bin1)"],
    data = ["//tests/binary-with-data:bin1"],
)

rule_test(
    name = "test-library-deps",
    size = "small",
    generates =
        [
            "testsZSlibrary-depsZSlibrary-deps/testsZSlibrary-depsZSlibrary-deps.conf",
            "testsZSlibrary-depsZSlibrary-deps/package.cache",
        ],
    rule = "//tests/library-deps",
)

rule_test(
    name = "test-library-with-sysdeps",
    size = "small",
    generates =
        [
            "testsZSlibrary-with-sysdepsZSlibrary-with-sysdeps/testsZSlibrary-with-sysdepsZSlibrary-with-sysdeps.conf",
            "testsZSlibrary-with-sysdepsZSlibrary-with-sysdeps/package.cache",
        ],
    rule = "//tests/library-with-sysdeps",
)

rule_test(
    name = "test-hsc",
    size = "small",
    generates = ["hsc"],
    rule = "//tests/hsc",
)

rule_test(
    name = "test-haddock",
    size = "small",
    generates = [
        "haddock/base-4.11.1.0",
        "haddock/index",
        "haddock/template-haskell-2.13.0.0",
        "haddock/testsZShaddockZShaddock-lib-a",
        "haddock/testsZShaddockZShaddock-lib-b",
        "haddock/testsZShaddockZShaddock-lib-deep",
    ],
    rule = "//tests/haddock",
)

rule_test(
    name = "test-haskell_lint-library",
    size = "small",
    generates = [
        "lint-log-lib-b",
    ],
    rule = "//tests/haskell_lint:lint-lib-b",
)

rule_test(
    name = "test-haskell_lint-binary",
    size = "small",
    generates = [
        "lint-log-bin",
    ],
    rule = "//tests/haskell_lint:lint-bin",
)

rule_test(
    name = "test-haskell_proto_library",
    size = "small",
    generates = [
        "testsZShaskellZUprotoZUlibraryZShs-lib/package.cache",
        "testsZShaskellZUprotoZUlibraryZShs-lib/testsZShaskellZUprotoZUlibraryZShs-lib.conf",
    ],
    rule = "//tests/haskell_proto_library:hs-lib",
)

rule_test(
    name = "test-haskell_doctest",
    size = "small",
    generates = [
        "doctest-log-doctest-lib-testsZShaskellZUdoctestZSlib-b",
    ],
    rule = "//tests/haskell_doctest:doctest-lib",
)

rule_test(
    name = "test-haskell_test",
    size = "small",
    generates = ["haskell_test"],
    rule = "//tests/haskell_test:haskell_test",
)

rule_test(
    name = "test-hidden-modules",
    size = "small",
    generates = [
        "testsZShidden-modulesZSlib-c/testsZShidden-modulesZSlib-c.conf",
        "testsZShidden-modulesZSlib-c/package.cache",
    ],
    rule = "//tests/hidden-modules:lib-c",
)

rule_test(
    name = "test-library-with-sysincludes",
    size = "small",
    generates =
        [
            "testsZSlibrary-with-sysincludesZSlibrary-with-sysincludes/testsZSlibrary-with-sysincludesZSlibrary-with-sysincludes.conf",
            "testsZSlibrary-with-sysincludesZSlibrary-with-sysincludes/package.cache",
        ],
    rule = "//tests/library-with-sysincludes",
)

rule_test(
    name = "test-package-id-clash",
    size = "small",
    generates =
        [
            "testsZSpackage-id-clashZSlib/testsZSpackage-id-clashZSlib.conf",
            "testsZSpackage-id-clashZSlib/package.cache",
        ],
    rule = "//tests/package-id-clash:lib",
)

rule_test(
    name = "test-java_classpath",
    size = "small",
    generates = ["java_classpath"],
    rule = "//tests/java_classpath",
)

rule_test(
    name = "test-cc_haskell_import-output",
    size = "small",
    generates = select({
        "@bazel_tools//src/conditions:darwin": [
            "libHStestsZSccZUhaskellZUimportZShs-lib-a-ghc{version}.dylib".format(version = ghc_version),
            "libHStestsZSccZUhaskellZUimportZShs-lib-b-ghc{version}.dylib".format(version = ghc_version),
        ],
        "//conditions:default": [
            "libHStestsZSccZUhaskellZUimportZShs-lib-a-ghc{version}.so".format(version = ghc_version),
            "libHStestsZSccZUhaskellZUimportZShs-lib-b-ghc{version}.so".format(version = ghc_version),
        ],
    }),
    rule = "//tests/cc_haskell_import:hs-lib-b-so",
)

rule_test(
    name = "test-cc_haskell_import-cc-link",
    size = "small",
    generates = ["cc-bin"],
    rule = "//tests/cc_haskell_import:cc-bin",
)

sh_inline_test(
    name = "test-haskell_binary-with-link-flags",
    size = "small",
    args = ["$(location //tests/binary-with-link-flags:binary-with-link-flags)"],
    data = ["//tests/binary-with-link-flags"],
    script = """\
set -e

# Fails if executable was linked without -threaded flag.
$1 +RTS -N
""",
)

rule_test(
    name = "test-lhs",
    size = "small",
    generates = ["lhs-bin"],
    rule = "//tests/lhs:lhs-bin",
)

rule_test(
    name = "test-hs-boot",
    size = "small",
    generates = ["hs-boot"],
    rule = "//tests/hs-boot:hs-boot",
)

rule_test(
    name = "test-textual-hdrs",
    size = "small",
    generates = ["textual-hdrs"],
    rule = "//tests/textual-hdrs:textual-hdrs",
)

rule_test(
    name = "test-two-libs",
    size = "small",
    generates = ["two-libs"],
    rule = "//tests/two-libs:two-libs",
)

genrule(
    name = "run-bin-with-lib",
    outs = ["dummy"],
    cmd = """sh -c '
    set -e
    $(location //tests/binary-with-lib:binary-with-lib)
    touch $(location dummy)
'""",
    tools = ["//tests/binary-with-lib"],
)

rule_test(
    name = "test-run-bin-with-lib",
    size = "small",
    generates = ["dummy"],
    rule = "//tests:run-bin-with-lib",
)

genrule(
    name = "run-bin-with-c-lib",
    outs = ["c-dummy"],
    cmd = """sh -c '
    set -e
    $(location //tests/c-compiles)
    touch $(location c-dummy)
'""",
    tools = ["//tests/c-compiles"],
)

rule_test(
    name = "test-run-bin-with-c-lib",
    size = "small",
    generates = ["c-dummy"],
    rule = "//tests:run-bin-with-c-lib",
)

haskell_binary(
    name = "run-tests",
    srcs = ["RunTests.hs"],
    deps = [
        "@hackage//:base",
        "@hackage//:hspec",
        "@hackage//:hspec-core",
        "@hackage//:process",
    ],
)
