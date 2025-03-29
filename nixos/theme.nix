{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    darkman
    catppuccin
    catppuccin-plymouth

    bibata-cursors
  ];

}
