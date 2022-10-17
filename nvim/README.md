### Config nvim

![Logo FLinguenheld](https://raw.githubusercontent.com/FLinguenheld/dotfiles/main/forelif.png "Pouet")

****
#### Requirements

##### Python/Pip
    sudo dnf install python3-pip  
    pip install --user --upgrade pynvim  
    pip install neovim

##### Nodejs
    sudo dnf install  nodejs  
    sudo npm install -g neovim

##### Treesitter
    sudo dnf groupinstall 'Development Tools'  
    sudo dnf install gcc-c++

##### Telescope
    sudo dnf install ripgrep  
    sudo dnf install fd-find

##### Clipboard
    sudo dnf install xclip

##### Packer
    https://github.com/wbthomason/packer.nvim  


***
#### Keys
|  Comp            |                           |
|------------------|---------------------------|
|`<C-f>`           |Scroll -4                  |
|`<C-i>`           |Scroll +4                  |
|`<C-e>`           |Exit                       |
|`<C-y> or enter`  |Confirm                    |


|  Comments      |                           |
|----------------|---------------------------|
|`gcc`           |Comment line               |
|`gbc`           |Comment bloc line          |
|`gcO`           |Comment above              |
|`gco`           |Comment underneath         |
|`gcA`           |Comment on right           |


|  Surround      |                                   |
|----------------|-----------------------------------|
|`yss"`          | Add " - sentence                  |
|`ysw"`          | Add " - cursor -> word            |
|`ysW"`          | Add " - cursor -> end sentence    |
|`ysE"`          | Add " - cursor -> end word        |
|                |                                   |
|`ds"`           | Remove "                          |
|                |                                   |
|`cs"'`          | Replace " by '                    |
|`cs([`          | Replace ( by [ with space         |
|`cs(]`          | Replace ( by [ without space      |


|  Trouble            |                           |
|---------------------|---------------------------|
|`<leader>xx`         | open trouble              |
|`<leader>rw`         | workspace diag            |
|`<leader>xd`         | Document diag             |
|`<leader>xl`         | Loc list                  |
|`<leader>xq`         | Quickfix                  |
|`gR`                 | lsp references            |


| File browser    |                                                                               |
|-----------------|-------------------------------------------------------------------------------|
| `<A-c>/c`       | Create file/folder at current `path` (trailing path separator creates folder) |
| `<A-r>/r`       | Rename multi-selected files/folders                                           |
| `<A-m>/m`       | Move multi-selected files/folders to current `path`                           |
| `<A-y>/y`       | Copy (multi-)selected files/folders to current `path`                         |
| `<A-d>/d`       | Delete (multi-)selected files/folders                                         |
| `<C-o>/o`       | Open file/folder with default system application                              |
| `<C-g>/g`       | Go to parent directory                                                        |
| `<C-e>/e`       | Go to home directory                                                          |
| `<C-w>/w`       | Go to current working directory (cwd)                                         |
| `<C-t>/t`       | Change nvim's cwd to selected folder/file(parent)                             |
| `<C-f>/f`       | Toggle between file and folder browser                                        |
| `<C-h>/h`       | Toggle hidden files/folders                                                   |
| `<C-s>/s`       | Toggle all entries ignoring `./` and `../`                                    |


