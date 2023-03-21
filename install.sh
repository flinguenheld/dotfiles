# sed -i 's/bullseye main/testing main/' /etc/apt/sources.list
# apt update -y
# apt upgrade -y

# --
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

# Neovim
    # Nodejs
apt install -y nodejs
npm install -g neovim

    # Telescope
apt install -y ripgrep
apt install -y fd-find

    # Clipboard
apt install -y xclip

apt install -y neovim


apt install -y x11-xserver-utils
apt install -y pipewire
apt install -y i3
apt install -y rofi
apt install -y kitty
apt install -y flameshot
apt install -y py3status

# apt install -y xfce4-power-manager
# apt install -y xfce4-settings
# apt install -y mediawriter

# Clock for py3status
pip install pytz
pip install tzlocal

# Mail & Google calendar
pip install oauth2client
pip install keyring

# --
apt install -y thunderbird
apt install -y pinta
apt install -y ristretto
apt install -y vlc
apt install -y libreoffice

# Pdf
apt install -y okular

# Scan
apt install -y xsane
