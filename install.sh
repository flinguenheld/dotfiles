dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf upgrade --refresh -y


# --
# dnf install -y xrandr
dnf install -y arandr
dnf install -y pipewire
dnf install -y rofi
dnf install -y terminator
dnf install -y flameshot
dnf install -y py3status
dnf install -y lua
dnf install -y git

dnf install -y xfce4-power-manager
dnf install -y xfce4-settings
dnf install -y mediawriter

# Fonts & Powerline
dnf install -y fontawesome-fonts
dnf install -y powerline powerline-fonts

git clone https://github.com/ryanoasis/nerd-fonts ~/fonts/
~/fonts/install.sh Hack
~/fonts/install.sh JetBrainsMono

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
dnf copr enable agriffis/neovim-nightly
dnf install -y neovim python3-neovim

    # Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim


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
dnf install vlc

# Vivaldi
dnf install -y dnf-utils
dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
dnf install -y vivaldi-stable

# Pdf
dnf install -y zathura

# --
mkdir ~/plugins/
git clone https://github.com/FLinguenheld/potpourri.nvim ~/plugins/
git clone https://github.com/FLinguenheld/luacomment.nvim ~/plugins/

git clone https://github.com/qmk/qmk_firmware ~/
git clone https://github.com/FLinguenheld/corne_keymap ~/qmk_firmware/keyboards/crkbd/keymaps/