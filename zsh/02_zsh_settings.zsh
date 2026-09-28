#!/usr/bin/zsh

# Settings for plugins
autoload -U select-word-style
select-word-style bash

# SET OPTIONS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt no_bang_hist # turn off history expansion using !
setopt interactivecomments # inlime comments
