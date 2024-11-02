{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git

    tldr
    bat
  ];
}
