# apt install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# apt install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

apt upgrade --refresh -y
# --
apt install -y lua
apt install -y git
apt install -y fzf

apt install -y locate
apt install -y tldr

# Fonts & Powerline
apt install -y fontawesome-fonts
apt install -y powerline powerline-fonts

# Neovim
    # Pip
apt install -y python3-pip
pip install --user --upgrade pynvim
pip install neovim

    # Nodejs
apt install -y  nodejs
npm install -g neovim

    # Treesitter
apt groupinstall 'Development Tools' -y
apt install -y gcc-c++

    # Telescope
apt install -y ripgrep
apt install -y fd-find

    # Clipboard
apt install -y xclip

    # Nightly
apt copr enable agriffis/neovim-nightly -y
apt install -y neovim python3-neovim


if [ "$1" != "docker" ]
then

    apt install -y arandr
    apt install -y pipewire
    apt install -y rofi
    apt install -y kitty
    apt install -y flameshot
    apt install -y nautilus
    apt install -y py3status

    apt install -y xfce4-power-manager
    apt install -y xfce4-settings
    apt install -y mediawriter

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

    # Vivaldi
    apt install -y dnf-utils
    apt config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
    apt install -y vivaldi-stable

    # Pdf
    apt install -y okular

    # Scan
    apt install -y xsane
fi
