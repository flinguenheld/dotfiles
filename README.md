### Config I3 / Py3status

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
![Logo FLinguenheld](https://raw.githubusercontent.com/FLinguenheld/dotfiles/main/forelif.png "Pouet")

****
#### Requirements
Don't forget to allow all scripts

#### Install
Up sources, [testing] contrib non-free  

    /etc/apt/sources.list

Install sudo and add privileges  

    /etc/sudoers

##### general
- arandr  
- rofi  
- terminator  
- flameshot  
- xfce4-power-manager  
- xfce4-settings  

##### py3status
https://py3status.readthedocs.io/en/latest/  

    sudo apt install py3status

##### google calendar
https://py3status.readthedocs.io/en/latest/user-guide/modules/#google_calendar  
Follow steps in the square and check the i3status.conf  

    pip install oauth2client

##### Fonts
https://github.com/ryanoasis/nerd-fonts  

    sudo apt install fonts-font-awesome

    ./install.sh Hack
    ./install.sh JetBrainsMono

##### Clock
    pip install pytz
    pip install tzlocal

##### Mail
Use keyring to set the password:  
https://pypi.org/project/keyring/  

    import keyring  
    keyring.set_password("mail", "flo", "password")  
    keyring.get_password("mail", "flo")  

##### Printer
Printing Navigate there for printer configuration:  

    http://localhost:631
