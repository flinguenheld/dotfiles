{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    # jetbrains-mono
    font-awesome
    noto-fonts-emoji
  ];
}
