{ pkgs, ... }:

{
  # Enable Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd niri-session";
        user = "flo";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tuigreet
  ];
}
