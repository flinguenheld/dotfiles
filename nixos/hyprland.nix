{ inputs, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    # pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprutils
    hyprlang
    hyprpaper

    wl-screenrec
    wl-clipboard
    wl-clip-persist
    cliphist

    waybar
    rofi-wayland
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
