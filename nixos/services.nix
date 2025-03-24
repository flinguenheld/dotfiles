{ pkgs, ... }:

{
  # Enable Services
  # programs.direnv.enable = true;
  services.mpd.enable = true;
  services.fwupd.enable = true;
  services.auto-cpufreq.enable = true;
  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
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
