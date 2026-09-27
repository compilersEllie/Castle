## !/usr/bin/zsh
#
# Settings for plugins
autoload -U select-word-style
select-word-style bash

# CUSTOM CONFIG

# SET OPTIONS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt no_bang_hist # turn off history expansion using !

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export EDITOR="$(echo -e "$(which nvim || which vim)" | tail -n 1)"
else
  export EDITOR="$(echo -e "$(which zed || which nvim || which vim)" | tail -n 1)"
fi
