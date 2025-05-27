{ pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.epson-escpr pkgs.epson-escpr2 ];
  environment.systemPackages = with pkgs; [
    cups
    cups-filters
    cups-pk-helper
    ipp-usb
    gutenprint
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

}
