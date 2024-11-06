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
    hyprsunset
    hyprutils
    hyprlang

    wl-screenrec
    wl-clipboard
    wl-clip-persist
    cliphist

    waybar
    rofi-wayland
    mako
    libnotify

    # qutebrowser
    # zathura
    # mpv
    # imv
  ];
}
