# .zshrc
# Folder : /home/

# ---------------------------------------------------------------------------------------------------- Exports ---
export PATH=/home/flo/bin/:$PATH

### Added by Zinit's installer ------------------------------------------------------------------------- Zinit ---
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ---------------------------------------------------------------------------------------------------- Plugins ---
zinit light jeffreytse/zsh-vi-mode

zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light agkozak/zsh-z

# ---------------------------------------------------------------------------------------------------- History ---
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# Append history to the history file (no overwriting)
setopt appendhistory
# Share history across terminals
setopt sharehistory
# Immediately append to the history file, not just when a term is killed
setopt incappendhistory
# Remove superfluous blanks from each command line being added to the history list
setopt histreduceblanks
# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading space
setopt histignorespace
# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt histignorealldups
# Add a bit more data (timestamp in unix epoch time and elapsed time of the command)
# setopt extended_history

# ------------------------------------------------------------------------------------------------------ Alias ---
alias ls='ls --color=auto'
alias la='ls -la'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# Python
alias senv='source env/bin/activate'
alias svenv='source venv/bin/activate'

mkcd() {
	mkdir -p "${1}" && cd "${1}"
}

# --------------------------------------------------------------------------------------------------- Exercism ---
exercism() {
	local out=$(command exercism "$@")
  echo "$out, have fun!"
  cd $out
}

# batsall() {
ba() {
	BATS_RUN_SKIPPED=true command bats *.bats
}

# --------------------------------------------------------------------------------------------- Starship & fzf ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"

# ------------------------------------------------------------------------------------------------------ Start ---
pfetch
