# .zshrc
# Folder : /home/

# https://zsh.sourceforge.io/Doc/Release/index.html#Top

# ---------------------------------------------------------------------------------------------------- Exports ---
export PATH=/home/$USER/bin/:$PATH
export PATH=/home/$USER/.local/bin/:$PATH
export PATH=$PATH:/home/flo/.cargo/bin

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

# ------------------------------------------------------------------------------------------------- Completion ---
autoload -U compinit; compinit

# ---------------------------------------------------------------------------------------------------- Plugins ---
# zinit light jeffreytse/zsh-vi-mode

zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light agkozak/zsh-z

zinit pack for fzf

# ---------------------------------------------------------------------------------------------------- History ---
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

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

# --------------------------------------------------------------------------------------------------- Bindkeys ---
# To know the code of a key, execute cat, press enter, press the key.
bindkey "^[b" backward-word 
bindkey "^[w" forward-word
bindkey "^[\^" beginning-of-line
bindkey "^[\$" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[u" undo
bindkey "^[r" redo
bindkey "^[\~" up-case-word
bindkey "^[\`" down-case-word
bindkey "^[c" kill-line  
bindkey "^[[3~" delete-char


# --------------------------------------------------------------------------------------------------- Exercism ---
exercism() {
	local out=$(command exercism "$@")
  if  echo "$out" | grep -q "$USER/exercism/" && echo "$out" | grep -qv "error"; then
    echo "cd $out... Have fun!"
    cd $out
  fi
}

# batsall() {
ba() {
	BATS_RUN_SKIPPED=true command bats *.bats
}

# --------------------------------------------------------------------------------------------- Starship & fzf ---
eval "$(starship init zsh)"

# ------------------------------------------------------------------------------------------------------ Start ---
pfetch
