# PATH: append, and skip a folder already in it
fish_add_path --append --path ~/bin ~/.local/bin

# Starship: its config lives in a folder, with its theme_apply
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml

# man pages through bat (colors follow the terminal theme)
# MANROFFOPT: man adds no formatting codes of its own
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c

if status is-interactive
    alias la="ls -la"
    alias ea="eza -la"

    # Colored help: typing --help anywhere expands to --help | bat -plhelp
    abbr -a --position anywhere -- --help '--help | bat -plhelp'

    starship init fish | source
    fzf --fish | source
    fastfetch --config examples/27.jsonc
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /home/flo/.ghcup/bin $PATH # ghcup-env
