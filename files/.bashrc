# Folder : /home/
# Same setup as ~/.config/fish/config.fish

# ── PATH (before the interactive check below) ────────

# Append a folder to PATH, unless it is already there
add_path() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$PATH:$1" ;;
    esac
}
add_path "$HOME/bin"
add_path "$HOME/.local/bin"
unset -f add_path
export PATH

. "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# ── INTERACTIVE ONLY ─────────────────────────────────

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la="ls -la"
alias ea="eza -la"

# Fallback prompt, replaced by starship
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"
eval "$(fzf --bash)"
fastfetch --config examples/27.jsonc
