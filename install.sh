dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf upgrade --refresh -y
# --
dnf install -y lua
dnf install -y git
dnf install -y fzf

dnf install -y locate
dnf install -y tldr

# Fonts & Powerline
dnf install -y fontawesome-fonts
dnf install -y powerline powerline-fonts

# Neovim
    # Pip
dnf install -y python3-pip
pip install --user --upgrade pynvim
pip install neovim

    # Nodejs
dnf install -y  nodejs
npm install -g neovim

    # Treesitter
dnf groupinstall 'Development Tools' -y
dnf install -y gcc-c++

    # Telescope
dnf install -y ripgrep
dnf install -y fd-find

    # Clipboard
dnf install -y xclip

    # Nightly
dnf copr enable agriffis/neovim-nightly -y
dnf install -y neovim python3-neovim


if [ "$1" != "docker" ]
then

    dnf install -y arandr
    dnf install -y pipewire
    dnf install -y rofi
    dnf install -y kitty
    dnf install -y flameshot
    dnf install -y nautilus
    dnf install -y py3status

    dnf install -y xfce4-power-manager
    dnf install -y xfce4-settings
    dnf install -y mediawriter

    # Clock for py3status
    pip install pytz
    pip install tzlocal

    # Mail & Google calendar
    pip install oauth2client
    pip install keyring

    # --
    dnf install -y thunderbird
    dnf install -y pinta
    dnf install -y ristretto
    dnf install -y vlc
    dnf install -y libreoffice

    # Vivaldi
    dnf install -y dnf-utils
    dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
    dnf install -y vivaldi-stable

    # Pdf
    dnf install -y okular

    # Scan
    dnf install -y xsane
fi
