#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent -t 1h >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Created by `pipx` on 2025-05-10 08:38:31
export PATH="$PATH:/home/ebithril/.local/bin"

export FLYCTL_INSTALL="/home/ebithril/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export PATH="/home/ebithril/.cargo/bin:$PATH"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
alias lazyvim='NVIM_APPNAME="lazyvim" nvim'
alias sm='send-message.sh'

fastfetch

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"
