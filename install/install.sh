# Edit /etc/apt/sources.list
# Add contrib non-free
# For debian 12 : contrib non-free-firmware
# Update
#
# Install sudo
# Add privileges to user in /etc/sudoers
#
# Install intel/amd microcode
# apt install intel-microcode
apt install -y amd64-microcode
#
# Graphic amd
apt install -y firmware-amd-graphics libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all
#
# I3
apt install -y i3
#
# Display manager
apt install -y lightdm

# --
apt update -y
# apt upgrade -y


# --
apt install -y python3
apt install -y python3-pip
apt install -y py3status

apt install -y lua5.4
apt install -y fzf

apt install -y locate
apt install -y tldr

# Fonts & Powerline
apt install -y powerline
apt install -y fonts-powerline
apt install -y fonts-font-awesome

apt install -y build-essential
apt install -y manpages-dev


#apt install -y x11-xserver-utils
apt install -y pulseaudio-utils
apt install -y pavucontrol
apt install -y xrandr
apt install -y arandr

apt install -y rofi
apt install -y kitty
apt install -y flameshot

apt install -y xfce4-power-manager
apt install -y xfce4-settings
# apt install -y mediawriter

# File manager
apt install -y pcmanfm
# Network manager wicd-gtk / nmtui
apt install -y network-manager
# Printing Navigate to http://localhost:631 for printer configuration
apt install -y cups


# Neovim
    # Telescope
apt install -y ripgrep
apt install -y fd-find
    # Clipboard
apt install -y xclip
    # Nodejs -> Install last version
#apt install -y nodejs
#apt install -y npm
#npm install -g neovim

# --
apt install -y firefox-esr
apt install -y thunderbird
apt install -y ristretto
apt install -y vlc
apt install -y libreoffice
# Pdf
apt install -y okular
# Scan
apt install -y xsane
