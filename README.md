## Copr

Download a repo file and place it to `/etc/yum.repos.d/`

example with
[wezterm](https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/),
click on the fedora version and create a file .repo

## Env

```
LayeredPackages: 'gcc-c++' bat bats cliphist exercism eza fastfetch fish fzf
gcc glow gmp-devel helix lazygit make mako ncurses-compat-libs
NetworkManager-tui niri perl ruff starship systemd-devel tealdeer tio ty unrar
uv wezterm
```

## Fish

`chsh -s $(which fish)`

## Fonts

- Create `~/.fonts/`
- Download nerd fonts (Hack, JetBrain, Fira)
- Unzip
- `fc-cache -fv`
- `fc-list`
