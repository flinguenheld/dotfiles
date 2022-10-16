dnf install -y rpmfusion-free-release-tainted
dnf install -y rpmfusion-nonfree-release-tainted

dnf upgrade --refresh -y


# --
dnf install -y xrandr
dnf install -y arandr
dnf install -y pipewire
dnf install -y rofi
dnf install -y terminator
dnf install -y flameshot
dnf install -y py3status


dnf install -y xfce4-power-manager
dnf install -y mediawriter

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

    # Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    # Nightly
dnf copr enable agriffis/neovim-nightly
dnf install -y neovim python3-neovim


# Clock for py3status
pip install pytz
pip install tzlocal

# Mail & Google calendar
pip install oauth2client
pip install keyring

# --
dnf install -y firefox
dnf install -y thunderbird

# Vivaldi
dnf install -y dnf-utils
dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
dnf install -y vivaldi-stable

# Pinta
dnf install -y pinta

# Pdf
dnf install -y zathura
