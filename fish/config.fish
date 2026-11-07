# PATH: append, and skip a folder already in it
fish_add_path --append --path ~/bin ~/.local/bin

if status is-interactive
    alias la="ls -la"
    alias ea="eza -la"

    starship init fish | source
    fzf --fish | source
    fastfetch --config examples/27.jsonc
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /home/flo/.ghcup/bin $PATH # ghcup-env
