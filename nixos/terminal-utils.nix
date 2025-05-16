{ pkgs, inputs, ... }:
{

  environment.systemPackages = with pkgs; [

    fishPlugins.fzf-fish

    alacritty
    kitty
    cool-retro-term

    starship

    helix
    # inputs.helix.packages.${pkgs.system}.default
    git
    ranger

    htop
    neofetch
    tldr
    bat
    ripgrep
    fd
    bc
    killall
    usbutils

    gnutar
    zip
    unzip

    picocom
    minicom
    wev # xev for wayland

    eza # ls
  ];

  programs.fish.enable = true;
}
