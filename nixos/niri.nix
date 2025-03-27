{ inputs, pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [

    # niri
    swaylock
    swayidle
    swaybg
    xwayland-satellite

    wayland-utils

    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
    
    wl-clipboard-rs
    wl-clip-persist

    waybar
    fuzzel
    mako
    libnotify

    slurp
    grim
    imagemagick # Color picker command

    # qutebrowser
    # zathura
    # mpv
    # imv
  ];
}
