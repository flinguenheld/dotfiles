{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flo = with pkgs; {
    isNormalUser = true;
    description = "flo";
    extraGroups = [ "networkmanager" "wheel" ];

    shell = fish;

    packages = [
      vesktop
      expressvpn
      vlc
      pinta

      qmk
      exercism
    ];
  };

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;
}
