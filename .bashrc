# general {{{1

# handy shortcuts:
# Ctrl-r: search command history (via an fzf search, in my case)
# Ctrl-l: clear screen except anything unexecuted in current line.

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
  alias v='nvim'
else
  export EDITOR=vim
fi

# disable bash history
unset HISTFILE

# # bash_history (in case you want it)
# HISTCONTROL=ignoreboth:erasedups
# HISTIGNORE='echo *':'rm *':'rmdir *':'sudo *'
# PROMPT_COMMAND='history -a'

# ------------------------------------------------------------------------------
# commands {{{1

if command -v eza >/dev/null 2>&1; then
  alias e1='eza -lTag --level=1 --icons=always --time-style=long-iso'
  alias e2='eza -lTag --level=2 --icons=always --time-style=long-iso'
  alias e3='eza -lTag --level=3 --icons=always --time-style=long-iso'
  alias e4='eza -lTag --level=4 --icons=always --time-style=long-iso'
else
  printf '%s\n' 'eza: command not found'
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --bash || true)"

  alias fz='fzf'

  fzf_bat='bat --style=numbers --color=always --theme=base16 {}'
  fzf_eza='eza -Tag --icons=always --color=always {}'
  fzf_fd='fd --type f --hidden --no-require-git --strip-cwd-prefix'

  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="${fzf_fd}"
  fi

  export FZF_DEFAULT_OPTS="
    -m
    --style=full
    --bind 'focus:transform-header:file --brief {}'
    # use '?' to toggle file preview
    --preview-window=hidden --bind '?:toggle-preview'
    --preview '([[ -f {} ]] && (${fzf_bat} || cat {})) || ([[ -d {} ]] && (${fzf_eza} | less)) || echo {} 2> /dev/null | head -200'
  "
else
  printf '%s\n' 'fzf: command not found'
fi

if command -v ledger >/dev/null 2>&1; then
  alias budg='ledger bal ^Asset:Budget'
  alias acc='ledger bal ^Asset:Liquid ^Liability -R'
else
  printf '%s\n' 'ledger: command not found'
fi

if command -v ugrep >/dev/null 2>&1; then
  # -R: --dereference-recursive
  # -I: --ignore-binary
  # -n: --line-number
  # -k: --column-number
  # -j: --smart-case
  # -u: --ungroup
  alias ugrep='ugrep --smart-case'
  alias lg='ugrep -RInk -j -u --hidden --ignore-files --tabs=1'
else
  printf '%s\n' 'ugrep: command not found'
fi

# ------------------------------------------------------------------------------
# aliases {{{1

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

alias ls='ls -FG'

# decent native substitute for eza.
alias ll="ls -GHhl -D '%FT%T'"

# print all env vars PLUS shell vars
alias printsh='(set -o posix ; set) | less'

alias vb='v ~/.bashrc'
alias vv='v ~/.config/nvim/init.lua'

# ------------------------------------------------------------------------------
# completion {{{1

# bash-completion@2 (for Bash 4.2+; use `bash-completion` for older versions)
if type brew >/dev/null 2>&1; then
  # shellcheck disable=2154
  if [ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]; then
    # shellcheck disable=1091
    . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      # shellcheck disable=1090
      [ -r "${COMPLETION}" ] && . "${COMPLETION}"
    done
  fi
fi

# ------------------------------------------------------------------------------
# last {{{1

# starship. keep this at the bottom.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash || true)"
else
  printf '%s\n' 'starship: command not found'
fi

# ------------------------------------------------------------------------------
# }}}1
