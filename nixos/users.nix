{ pkgs, inputs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flo = with pkgs; {
    isNormalUser = true;
    description = "flo";
    extraGroups = [ "networkmanager" "wheel" ];

    shell = fish;

    packages = [
      vesktop
      fractal # Matrix
      expressvpn
      vlc
      qimgv   # Image viewer
      pinta
      libreoffice-qt6-still

      qmk
      exercism
      codecrafters-cli

      kicad
    ];
  };

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;
  services.expressvpn.enable = true;
}
