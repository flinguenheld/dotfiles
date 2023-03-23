# Edit /etc/apt/sources.list
# Add contrib non-free
# Update
#
# Install sudo
# Add privileges to user in /etc/sudoers
#
# Install intel/amd microcode
# apt install intel-microcode
apt install amd64-microcode
#
# I3
apt install i3
#
# Display manager
apt install lightdm

# --
apt update -y
# apt upgrade -y

# Graphic amd
apt install -y firmware-amd-graphics libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all


# --
apt install -y python3
apt install -y python3-pip

apt install -y lua5.4
apt install -y fzf

apt install -y locate
apt install -y tldr
tldr -u

# Fonts & Powerline
apt install -y powerline
apt install -y fonts-powerline


apt install -y build-essential
apt install -y manpages-dev


#apt install -y x11-xserver-utils
apt install -y pulseaudio-utils
apt install -y pavucontrol

apt install -y rofi
apt install -y kitty
apt install -y flameshot
apt install -y py3status
# pip3 install py3status

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


# Clock for py3status
pip install pytz
pip install tzlocal

# Mail & Google calendar
pip install oauth2client
pip install keyring

# Anglais
pip install beautifulsoup4

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
