{
  description = "Pouet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    helix.url = "github:helix-editor/helix";
  };

  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.flopc = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
            ./configuration.nix

            ./bootloader.nix
            ./display-manager.nix
            ./networking.nix

            ./users.nix
            ./environment-variables.nix
            ./services.nix

            # ./hyprland.nix
            ./niri.nix
            ./fonts.nix
            ./theme.nix

            ./terminal-utils.nix

            ./sound.nix
            ./bluetooth.nix

            ./screen.nix

            ./programming-languages.nix
            ./lsp.nix
           ];
      };
    };
}
