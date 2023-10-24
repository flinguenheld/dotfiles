### Config Arch / Hyprland

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
![Logo FLinguenheld](https://raw.githubusercontent.com/FLinguenheld/dotfiles/main/forelif.png "Pouet")

---

##### general

    tldr nodejs npm starship pfetch python-pip thunderbird vlc pinta
    wofi wl-clipboard cliphist hyprpicker

##### Fonts

https://github.com/ryanoasis/nerd-fonts  
https://aur.archlinux.org/packages?K=nerd-fonts-&outdated=off

    yay nerd-fonts-git

##### Mail

Use keyring to set the password:  
https://pypi.org/project/keyring/

##### Printers

Network printers are automatically detected by cups.  
If there is a problem, try to edit the file `/etc/nsswitch.conf` and update the line **hosts**:  
hosts: … `mdns_minimal [NOTFOUND=return]` resolve [!UNAVAIL=return] dns …
