{

  description = "Pouet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix

            ./display-manager.nix
            ./hyprland.nix
            ./fonts.nix

            ./terminal-utils.nix

           ];
        };
      };
    };
}
