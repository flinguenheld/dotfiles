{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    alacritty
    cool-retro-term
    starship

    helix

    git

    neofetch
    tldr
    bat
    bc
  ];
}
