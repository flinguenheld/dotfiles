{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    catppuccin
    catppuccin-cursors.latteLight
    catppuccin-plymouth
    catppuccin-gtk

    numix-icon-theme-circle
    colloid-icon-theme
  ];

    # catppuccin.enable = true;
  # catppuccin.nixModules.flavor = "mocha";

  # Enable Theme
  environment.variables.GTK_THEME = "catppuccin-macchiato";
  environment.variables.XCURSOR_THEME = "Quintom_Snow";
  environment.variables.XCURSOR_SIZE = "38";

  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";
  
  # environment.variables.HYPRCURSOR_THEME = "Catppuccin-Macchiato";
  # environment.variables.HYPRCURSOR_SIZE = "24";
  # qt.enable = true;
  # qt.platformTheme = "gtk2";
  # qt.style = "gtk2";
  # console = {
  #   earlySetup = true;
  #   colors = [
  #     "24273a"
  #     "ed8796"
  #     "a6da95"
  #     "eed49f"
  #     "8aadf4"
  #     "f5bde6"
  #     "8bd5ca"
  #     "cad3f5"
  #     "5b6078"
  #     "ed8796"
  #     "a6da95"
  #     "eed49f"
  #     "8aadf4"
  #     "f5bde6"
  #     "8bd5ca"
  #     "a5adcb"
  #   ];
  # };



  # environment.systemPackages = with pkgs; [
  #   numix-icon-theme-circle
  #   colloid-icon-theme
  #   catppuccin-gtk
  #   catppuccin-kvantum
  #   catppuccin-cursors.macchiatoTeal

  #   gnome.gnome-tweaks
  #   gnome.gnome-shell
  #   gnome.gnome-shell-extensions
  # ];
}
