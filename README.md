### Config I3 / Py3status

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
![Logo FLinguenheld](https://raw.githubusercontent.com/FLinguenheld/dotfiles/main/forelif.png "Pouet")

---

##### general

- arandr
- rofi
- terminator
- flameshot
- xfce4-power-manager
- xfce4-settings

##### Fonts

https://github.com/ryanoasis/nerd-fonts

    sudo apt install fonts-font-awesome

    ./install.sh Hack
    ./install.sh JetBrainsMono

##### Mail

Use keyring to set the password:  
https://pypi.org/project/keyring/

    import keyring
    keyring.set_password("mail", "flo", "password")
    keyring.get_password("mail", "flo")

##### Printer

Printing Navigate there for printer configuration:

    http://localhost:631
