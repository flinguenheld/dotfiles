# Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Fonts
git clone https://github.com/ryanoasis/nerd-fonts ~/fonts/nerd-fonts
~/fonts/install.sh Hack
~/fonts/install.sh JetBrainsMono

# --
mkdir ~/plugins/
git clone https://github.com/FLinguenheld/potpourri.nvim ~/plugins/potpourri.nvim
git clone https://github.com/FLinguenheld/luacomment.nvim ~/plugins/luacomment.nvim

git clone https://github.com/qmk/qmk_firmware ~/qmk_firmware
git clone https://github.com/FLinguenheld/corne_pie ~/qmk_firmware/keyboards/crkbd/keymaps/corne_pie