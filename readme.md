### Config NixOS / Hyprland

---

##### Links

[NixOS wiki](https://nixos.wiki/wiki/Main_Page)  
[NixOS packages](https://search.nixos.org/packages)  
[NixOS options](https://nixos.org/manual/nixos/unstable/options.html)  
[My NixOS](https://mynixos.com/)  

[XNM1 dotfiles](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles)  

##### Commands

``` sudo nixos-rebuild switch --flake .#flopc ```

##### Miscellaneous

if command not found isn't found:  
``` sudo nix-channel --update ```

cursor trouble (as mention [here](https://wiki.hyprland.org/Hypr-Ecosystem/hyprcursor/#important-notes)):  
``` dconf write /org/gnome/desktop/interface/cursor-theme "'Bibata-Modern-Ice'" ```   
``` dconf write /org/gnome/desktop/interface/cursor-size 35 ```

Printer:  

Add it with cups [http://localhost:631](http://localhost:631)  
And use `lpstats` to check jobs.  

