#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2025-05-10 08:38:31
export PATH="$PATH:/home/ebithril/.local/bin"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
