function do_arrive() {
  local PKG_MAN=$(pkg_man)

  link "${HOME}/src/nvim" "${HOME}/.config/nvim"
  link "${HOME}/.config/zshrc" "${HOME}/.zshrc"
  link "${HOME}/.config/gitconfig" "${HOME}/.gitconfig"
  link "${HOME}/.config/pylintrc" "${HOME}/.pylintrc"

  cat "${HOME}/.config/crontab" | crontab 1> /dev/null

  # LOAD EXTERNALS
  program zsh
  program fzf
  program nvim neovim
  setup git "${GIT_BIN}" "${PKG_MAN} git"
  program python3
  if [[ "$OSTYPE" != "linux-android" ]]; then
    program kitty
    program rustup
  fi
  dotfile gitconfig
  dotfile pylintrc
  dotfile zshrc
}
