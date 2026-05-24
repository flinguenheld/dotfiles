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
      gnome2.GConf
    ];
  };

# Thunar


programs.thunar.enable = true;
services.gvfs.enable = true; # Mount, trash, and other functionalities
services.tumbler.enable = true; # Thumbnail support for images
environment.systemPackages = with pkgs; [
    thunar-archive-plugin
    thunar-volman
    xfconf
  ];
}
