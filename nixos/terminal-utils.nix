{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [

    fishPlugins.fzf-fish

    alacritty
    kitty
    cool-retro-term

    starship

    helix

    git

    neofetch
    tldr
    bat
    fd
    bc
    killall
  ];

  programs.fish.enable = true;
}
