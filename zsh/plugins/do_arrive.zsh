#!/usr/bin/zsh

function do_arrive() {
  if [[ ! -n $ZDOTDIR ]]; then
    echo "Setting ZDOTDIR" 2> /dev/stderr
    cat "${HOME}/.config/zsh/bootstrap" >> "$PREFIX/etc/zshrc"
  fi

  local PKG_MAN=$(pkg_man)

  link "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshenv" "${HOME}/.zshenv"
  link "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshrc" "${HOME}/.zshrc"
  link "${HOME}/src/nvim" "${HOME}/.config/nvim"
  link "${HOME}/.config/cargo/config.toml" "${XDG_DATA_HOME}/cargo/config.toml"
  cat "${HOME}/.config/crontab" | crontab 1> /dev/null

  # LOAD EXTERNALS
  program zsh
  program nvim neovim
  setup git "${GIT_BIN}" "${PKG_MAN} git"
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
  dotfile termux
}
