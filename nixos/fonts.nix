{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    # fira-code-symbols # ??
    
    font-awesome
    # noto-fonts-emoji
  ];

}
