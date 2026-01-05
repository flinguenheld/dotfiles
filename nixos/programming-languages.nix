{ inputs, pkgs, ... }:

{
  # # Apply the overlay to the package set
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    gcc
    clang-tools
    gnumake
    # gdb
    # valgrind

    norminette
    clang

    python3
    
    nodePackages_latest.nodejs
    nodePackages_latest.pnpm
    lua
    go

          (rust-bin.stable.latest.default.override {
          # (rust-bin.nightly.latest.default.override {
                # extensions = [ "rust-src" ];
                targets = [ "thumbv6m-none-eabi" ];
              })

    cargo
    rustfmt
    rust-analyzer
    clippy
    taplo
    cargo-outdated
    bacon

    # Convert ELF files to UF2 for USB Flashing Bootloaders
    elf2uf2-rs
    probe-rs-tools
    flip-link

    # --
    docker
    docker-compose
  ];
}
