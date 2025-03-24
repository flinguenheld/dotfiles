{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    niri
    swaylock
    swayidle
    xwayland-satellite

    wl-screenrec
    wl-clipboard
    wl-clip-persist
    cliphist

    waybar
    fuzzel
    mako
    libnotify

    slurp
    grim

    # qutebrowser
    # zathura
    # mpv
    # imv
  ];

}
