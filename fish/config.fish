set -x PATH $PATH ~/bin/

alias la="ls -la"
alias ea="eza -la"

function fish_user_key_bindings
    if command -s fzf-share >/dev/null
        source (fzf-share)/key-bindings.fish
    end

    # fzf_key_bindings
end

starship init fish | source
fastfetch --config examples/27.jsonc

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/flo/.ghcup/bin $PATH # ghcup-env