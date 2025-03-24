{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-font-patcher
    noto-fonts-color-emoji

    jetbrains-mono
  ];
}
