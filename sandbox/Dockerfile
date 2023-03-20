FROM debian:latest

RUN mkdir -p ~/bash
RUN mkdir -p ~/cpp
RUN mkdir -p ~/dotfiles
RUN mkdir -p ~/install
RUN mkdir -p ~/.config

RUN apt -y update && apt -y upgrade

RUN apt install -y man
RUN apt install -y man-db
RUN apt install -y git
RUN apt install -y wget
RUN apt install -y curl
RUN apt install -y fzf

RUN apt install -y tldr
# RUN tldr -u

RUN apt install -y locate

RUN apt install -y powerline
RUN apt-get install fonts-powerline

# Neovim
    # Pip
RUN apt install -y python3-pip
RUN pip install --user --upgrade pynvim
RUN pip install neovim
RUN pip install flake8

    # Nodejs
RUN apt install -y nodejs npm
RUN npm install -g neovim

    # Treesitter
RUN apt install -y build-essential
RUN apt install -y cmake
RUN apt install -y manpages-dev

    # Telescope
RUN apt install -y ripgrep
RUN apt install -y fd-find

    # Clipboard
RUN apt install -y xclip

# --
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb -O ~/install/nvim-linux64.deb
RUN apt install ~/install/nvim-linux64.deb

# --
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN git clone --depth 1 https://github.com/FLinguenheld/dotfiles ~/dotfiles


# docker run -it [tag]

# docker start [container-id]
# docker exec -it [container-id] bash
