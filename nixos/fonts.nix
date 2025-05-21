{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    
    font-awesome
    noto-fonts-emoji
  ];
}
