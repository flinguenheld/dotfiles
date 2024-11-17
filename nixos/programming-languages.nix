{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    clang
    (python312Full.withPackages(ps: with ps; [ pygobject3 gobject-introspection pyqt6-sip]))
    nodePackages_latest.nodejs
    nodePackages_latest.pnpm
    lua
    go

    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy
    taplo
  ];
}
