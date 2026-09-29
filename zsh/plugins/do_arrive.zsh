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
  crate zsg-patina
  crontab "${HOME}/.config/crontab" 1> /dev/null
}

function do_arrive_configs() {
  if [[ ! -n $ZDOTDIR ]]; then
    echo "Setting ZDOTDIR" 2> /dev/stderr
    cat "${HOME}/.config/zsh/bootstrap" >> "$PREFIX/etc/zshrc"
  fi
  link "${HOME}/.config" "${HOME}/src/Castle"

  repo "nvim config" "git@github.com/compilersEllie/nvim_config" "${HOME}/.config/nvim"
  link "${HOME}/.config/nvim" "${HOME}/src/nvim_config"
  link "${HOME}/.config/cargo/config.toml" "${HOME}/.cache/cargo/config.toml"
  setup "zshrc stub" "${HOME}/.zshrc" "touch ${HOME}/.zshrc" # To silence zsh's help
  setup "fzf zsh" "${HOME}/.config/zsh/fzf.zsh" "fzf --zsh >> \"${HOME}/.config/zsh/fzf.zsh\""
  dotfile termux

  # Remove the plugin file so antidote installs
  rm ${HOME}/.config/zsh/plugins.zsh
}

function do_arrive_antidote() {
  repo "antidote" "https://github.com/mattmc3/antidote" "${ANTIDOTE_HOME}"
  link "${ANTIDOTE_HOME}" "${HOME}/src/antidote"
  source "${ZDOTDIR}/functions/antidote-projects"
  source "${ANTIDOTE_HOME}/antidote.zsh"
}

function do_arrive() {
  # Setup our config & repos
  do_arrive_configs
  do_arrive_packages
  do_arrive_antidote
}
