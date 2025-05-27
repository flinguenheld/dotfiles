{ pkgs, ... }:

{
  # Enable Services
  programs.direnv.enable = true;
  services.mpd.enable = true;
  services.fwupd.enable = true;
  # services.auto-cpufreq.enable = true;
  programs.dconf.enable = true;
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      xfce.xfconf
      gnome2.GConf
    ];
  };

# Thunar
programs.thunar.enable = true;
programs.xfconf.enable = true;
services.gvfs.enable = true; # Mount, trash, and other functionalities
services.tumbler.enable = true; # Thumbnail support for images
programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
}
