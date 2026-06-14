## Copr
Download a repo file and place it to `/etc/yum.repos.d/`

example with [wezterm](https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/),
click on the fedora version and create a file .repo

## Env
LayeredPackages: bat cliphist eza fastfetch fish fzf helix mako niri starship tealdeer wezterm

## Fish
`chsh -s $(which fish)`

## Fonts
- Create `~/.fonts/`
- Download nerd fonts (Hack, JetBrain, Fira)
- Unzip
- `fc-cache -fv`
- `fc-list`
