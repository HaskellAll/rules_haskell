{ pkgs ? import ./nixpkgs {} }:

with pkgs;

mkShell {
  # XXX: hack for macosX, this flags disable bazel usage of xcode
  # Note: this is set even for linux so any regression introduced by this flag
  # will be catched earlier
  # See: https://github.com/bazelbuild/bazel/issues/4231
  BAZEL_USE_CPP_ONLY_TOOLCHAIN=1;

  buildInputs = [
    go
    graphviz
    nix
    which
    perl
    python
    python36Packages.sphinx
    zip
    unzip
    bazel
    # needed for cloning protobuf in @com_google_protobuf
    git
  ];

  shellHook = ''
    # source bazel bash completion
    source ${pkgs.bazel}/share/bash-completion/completions/bazel
  '';
}
