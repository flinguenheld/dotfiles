{ pkgs, ... }:

{
  # Setup Env Variables
  environment = with pkgs; {
    shells = [ bash fish ];
    variables = {
      EDITOR = "hx";
      # GTK_USE_PORTAL = "1";
      XDG_CURRENT_DESKTOP = "GNOME";
      # XDG_SESSION_TYPE = "wayland";

      # 16 20 22 24 28 32 40 48 56 64 72 80 88 96
      # GTK_THEME = "catppuccin-macchiato";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "32";
    };
  };
}
