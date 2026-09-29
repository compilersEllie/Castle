#!/usr/bin/zsh

# Settings for plugins
autoload -U select-word-style
select-word-style bash

# SET OPTIONS
setopt autocd
setopt inc_append_historY
setopt share_history
setopt histignorealldupS
setopt extendedglob
setopt no_bang_hist # turn off history expansion using !
setopt interactivecomments # inlime comments
