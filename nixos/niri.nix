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

    wl-clipboard
    wl-clip-persist
    cliphist

    waybar
    fuzzel
    mako
    libnotify

    # qutebrowser
    # zathura
    # mpv
    # imv
  ];
}
