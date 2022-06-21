### Config I3 / Py3status

![Logo FLinguenheld](https://raw.githubusercontent.com/FLinguenheld/dotfiles/main/forelif.png "Pouet")

****
#### Requirements

Don't forget to allow all scripts

##### general
- xrandr
- pipewire  
- rofi  
- terminator  
- flameshot   (screenshot)  

##### py3status
https://py3status.readthedocs.io/en/latest/  

    sudo dnf install py3status

##### google calendar
https://py3status.readthedocs.io/en/latest/user-guide/modules/#google_calendar  
Follow steps in the square  

    pip install oauth2client

##### Fonts
https://github.com/ryanoasis/nerd-fonts  

    sudo dnf install fontawesome-fonts

    ./install.sh Hack
    ./install.sh JetBrainsMono

##### Clock
    pip install pytz
    pip install tzlocal

##### Mail
Use keyring to set the password :  
https://pypi.org/project/keyring/  

    import keyring  
    keyring.set_password("mail", "flo", "password")  
    keyring.get_password("mail", "flo")  


##### Powerline
https://fedoramagazine.org/add-power-terminal-powerline/  

    sudo dnf install powerline powerline-fonts

##### Printer
    sudo system-config-printer

##### Discord
https://itsfoss.com/install-discord-linux/#traditional-method
