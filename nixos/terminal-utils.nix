{ pkgs, inputs, ... }:
{

  environment.systemPackages = with pkgs; [

    fishPlugins.fzf-fish

    alacritty
    kitty
    # cool-retro-term

    starship

    helix
    vim
    # emacs
    # inputs.helix.packages.${pkgs.system}.default
    git
    # ranger

    fzf
    htop
    neofetch
    tealdeer # tldr
    eza # ls
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

  ];

  programs.fish.enable = true;
}
