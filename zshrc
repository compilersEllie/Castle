## !/usr/bin/zsh
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

export HOME="$(cd;pwd)"
export ANTIDOTE_HOME=${HOME}/.cache/antidote

if [[ ! -d ${ANTIDOTE_HOME} ]]; then
  git clone https://github.com/mattmc3/antidote ${ANTIDOTE_HOME}
  source "${ANTIDOTE_HOME}/antidote.zsh"
  # Install plugins if there are plugins that have not been installed
  antidote install
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# To customize prompt, run `p10k configure` or edit ~/.config/p10k.zsh.
if [[ -r "${HOME}/.cache/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${HOME}/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for _rc in  ${HOME}/.config/*.zsh(n); do
  if [[ $_rc == */zsh_plugins.zsh ]]; then
    continue
  fi
  if [[ $_rc:t != '~'* ]]; then # Ignore tilde files.
    source "$_rc"
  fi
done
unset _rc

if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof > "${HOME}/.zrcprof.log" &!
fi
