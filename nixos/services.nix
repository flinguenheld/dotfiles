{ pkgs, ... }:

{
  # Enable Services
  # programs.direnv.enable = true;
  programs.fish.enable = true;
  services.mpd.enable = true;
  programs.thunar.enable = true;
  # programs.thunar.plugins = [ "thunar-volman" ];
  services.fwupd.enable = true;
  services.auto-cpufreq.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
