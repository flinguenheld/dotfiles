# .bashrc
# Folder : /home/

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
# set PATH so it includes user's private bin if it exists
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

if ! [[ "$PATH" =~ "/sbin:" ]]; then
	PATH="/sbin:$PATH"
fi

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# enable bash completion in interactive shells
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

mkcd() {
	mkdir -p "${1}" && cd "${1}"
}

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias la='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Flo --
alias yk='xclip -r -selection clipboard'
alias senv='source env/bin/activate'
alias svenv='source venv/bin/activate'
alias fd='fdfind'

EDITOR=/usr/bin/nvim

# FZF --
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

v() { du -a ~/ | awk '{print $2}' | fzf | xargs -r $EDITOR; }

# Starship
eval "$(starship init bash)"
# . "$HOME/.cargo/env"

# -----------------------------------------------------
# PFETCH
# -----------------------------------------------------
echo ""
pfetch
# neofetch

# -----------------------------------------------------
# EXERCISM
# -----------------------------------------------------
exercism() {
	local out
	readarray -t out < <(command exercism "$@")
	printf '%s\n' "${out[@]}"
	if [[ $1 == "download" && -d "${out[-1]}" ]]; then
		cd "${out[-1]}" || return 1
	fi
}

batsall() {
	BATS_RUN_SKIPPED=true command bats *.bats
}

source /home/flo/.config/broot/launcher/bash/br
