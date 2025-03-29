{ pkgs, ... }:

{
  # Setup Env Variables
  environment = with pkgs; {
    shells = [ bash fish ];
    variables = {
      EDITOR = "hx";
      # MOZ_ENABLE_WAYLAND = "1";
      # MOZ_DBUS_REMOTE = "1";
      # GTK_USE_PORTAL = "1";
      XDG_CURRENT_DESKTOP = "GNOME";

      # 16 20 22 24 28 32 40 48 56 64 72 80 88 96
      # GTK_THEME = "catppuccin-macchiato";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "32";
    };
  };
}
