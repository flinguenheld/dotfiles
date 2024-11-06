{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    # https://github.com/googlefonts/noto-emoji?tab=readme-ov-file
    noto-fonts-color-emoji

    (nerdfonts.override { fonts = [ "JetBrainsMono" "MartianMono" "Recursive" ]; })
  ];


#   fonts.packages = with pkgs; [
#   (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
# ];
}
