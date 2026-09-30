#!/usr/bin/zsh

function is-laptop() {
  [[ $OSTYPE != linux-android ]]
}

function do_arrive_packages() {
  local PKG_MAN=$(pkg_man)

  program zsh
  program nvim neovim
  program python3
  program luarocks
  program hyperfine
  program mosh
  if is-laptop; then
    program kitty
    program rustup
  fi
  program sccache
  program bat
  crate cog cocogitto cog
  crate zsh-patina
  crontab "${HOME}/.config/crontab" 1> /dev/null
}

function do_arrive_configs() {
  if [[ ! -n $ZDOTDIR ]]; then
    echo "Setting ZDOTDIR" 2> /dev/stderr
    cat "${HOME}/.config/zsh/bootstrap" >> "$PREFIX/etc/zshrc"
  fi

  link "${HOME}/.cache/antidote/github.com" "${HOME}/src"

  link "${HOME}/src/compilersEllie/nvim_config" "${HOME}/.config/nvim"
  link "${HOME}/.config/cargo/config.toml" "${HOME}/.cache/cargo/config.toml"
  link "${ANTIDOTE_HOME}" "${HOME}/src/mattmc3/antidote"
  setup "zshrc stub" "${HOME}/.zshrc" "touch ${HOME}/.zshrc" # To silence zsh's help
  setup "fzf zsh" "${HOME}/.config/zsh/fzf.zsh" "fzf --zsh >> \"${HOME}/.config/zsh/fzf.zsh\""
  dotfile termux
}

function do_arrive_antidote() {
  # Remove the plugin file so antidote installs
  rm ${HOME}/.config/zsh/plugins.zsh

  repo "antidote" "https://github.com/mattmc3/antidote" "${ANTIDOTE_HOME}"
  source "${ANTIDOTE_HOME}/antidote.zsh"
}

function do_arrive() {
  # Setup our config & repos
  do_arrive_antidote
  do_arrive_configs
  do_arrive_packages
}
