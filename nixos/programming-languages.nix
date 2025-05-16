{ inputs, pkgs, ... }:

{

  # Apply the overlay to the package set
  nixpkgs.overlays = [
    # inputs.rust-overlay.overlays.default
    inputs.rust-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    gcc
    clang
    (python312Full.withPackages(ps: with ps; [ pygobject3 gobject-introspection pyqt6-sip]))
    nodePackages_latest.nodejs
    nodePackages_latest.pnpm
    lua
    go

          (rust-bin.stable.latest.default.override {
          # (rust-bin.nightly.latest.default.override {
                # extensions = [ "rust-src" ];
                targets = [ "thumbv6m-none-eabi" ];
              })

    # rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
    #   extensions = [ "rust-src" ];
    #                 targets = [ "thumbv6m-none-eabi" ];
    # })

    # rustc
    cargo
    rustfmt
    rust-analyzer
    clippy
    taplo
    cargo-outdated

    # Convert ELF files to UF2 for USB Flashing Bootloaders
    elf2uf2-rs
    probe-rs-tools
    flip-link

    
  ];
}
