{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    alacritty
    cool-retro-term
    starship

    helix

    git

    neofetch
    sqlite  # Required by neofetch
    tldr
    bat
    bc
  ];
}
