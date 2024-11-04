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
