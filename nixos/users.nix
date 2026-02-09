{ pkgs, inputs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flo = with pkgs; {
    isNormalUser = true;
    description = "flo";
    extraGroups = [ "networkmanager" "wheel" ];

    shell = fish;

    packages = [
      # vesktop
      discord
      # fractal # Matrix
      expressvpn
      vlc
      qimgv   # Image viewer
      pinta
      # libreoffice-qt6-still

      # qmk
      exercism
      # codecrafters-cli

      # kicad

      # brave
      bitwarden-desktop
    ];
  };

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;
  services.expressvpn.enable = true;


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

}
