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

## Theme

Default: catppuccin_frappe.

`Mod+T` (or the bar icon) opens `theme_menu`. The accent colors are shuffled,
`--original` keeps the theme's order. After a fresh install, pick a theme once:
the generated files are not in git.

```
Mod+T ─► theme_menu [--original]
           │
           ├─► niri/scripts/theme/theme_make_palette <theme>
           │     ─► ~/.config/theme/palette.toml   background … alert, c0 … c6, dark
           │
           ├─► ~/.config/*/theme_apply   source palette.toml, write, reload
           │     niri/       focus ring in config/style.kdl, then config.kdl
           │     waybar/     palette.css
           │     mako/       palette
           │     fuzzel/     palette.ini
           │     starship/   [palettes.generated] at the end of starship.toml
           │     gtk-3.0/    gsettings color-scheme (light or dark)
           │
           ├─► sed: the theme name only ─► wezterm, glow, helix
           │
           └─► niri/scripts/startup ─► swaybg   wallpaper ($theme.jpg)
                                       swayidle lock screen ($background)
                                       waybar   restarted with the new colors
```
