{

  description = "Pouet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, ...} @ inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix

            ./bootloader.nix
            ./display-manager.nix
            ./networking.nix

            ./users.nix
            ./environment-variables.nix
            ./services.nix

            ./hyprland.nix
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
    };
}
