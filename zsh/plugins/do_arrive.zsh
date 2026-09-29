#!/usr/bin/zsh

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
  crate bat
  setup zsh-patina "$_ZSH_PATINA_PATH" "cargo install zsh-patina"
  crontab "${HOME}/.config/crontab" 1> /dev/null
}

function do_arrive_configs() {
  if [[ ! -n $ZDOTDIR ]]; then
    echo "Setting ZDOTDIR" 2> /dev/stderr
    cat "${HOME}/.config/zsh/bootstrap" >> "$PREFIX/etc/zshrc"
  fi

  repo "nvim config" "git@github.com/compilersEllie/nvim_config" "${HOME}/.config/nvim"
  link "${HOME}/.config/nvim" "${HOME}/src/nvim_config"
  link "${HOME}/.config/cargo/config.toml" "${HOME}/.cache/cargo/config.toml"
  setup "zshrc stub" "${HOME}/.zshrc" "touch ${HOME}/.zshrc" # To silence zsh's help
  dotfile termux
}

function do_arrive_antidote() {
  repo "antidote" "https://github.com/mattmc3/antidote" "${ANTIDOTE_HOME}"
  link "${ANTIDOTE_HOME}" "${HOME}/src/antidote"
  source "${ZDOTDIR}/functions/antidote-projects"
  source "${ANTIDOTE_HOME}/antidote.zsh"
  antidote install
}

function do_arrive() {
  # Setup our config & repos
  do_arrive_configs
  do_arrive_packages
  do_arrive_antidote
}
