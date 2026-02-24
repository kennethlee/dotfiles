# general

# bash_history
unset HISTFILE
# HISTCONTROL=ignoreboth:erasedups
# HISTIGNORE='echo *':'rm *':'rmdir *':'sudo *'
# PROMPT_COMMAND='history -a'

# ------------------------------------------------------------------------------
# commands {{{1

if ! command -v bat >/dev/null 2>&1; then
  printf '%s\n' '* Not found: bat.'
fi

if command -v eza >/dev/null 2>&1; then
  alias e1='eza -lTag --level=1 --icons=always --time-style=long-iso'
  alias e2='eza -lTag --level=2 --icons=always --time-style=long-iso'
  alias e3='eza -lTag --level=3 --icons=always --time-style=long-iso'
  alias e4='eza -lTag --level=4 --icons=always --time-style=long-iso'
else
  printf '%s\n' '* Not found: eza.'
fi

if ! command -v fd >/dev/null 2>&1; then
  printf '%s\n' '* Not found: fd.'
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --bash || true)"

  alias fz='fzf'

  # feed fzf with fd (if installed); otherwise, with rg.
  fzf_bat='bat --style=numbers --color=always --theme=base16 {}'
  fzf_eza='eza -Tag --icons=always --color=always {}'
  fzf_fd='fd --type f --hidden --no-require-git --strip-cwd-prefix'
  fzf_rg='rg --files --hidden --no-require-git --follow'
  FZF_DEFAULT_COMMAND=''

  if command -v fd >/dev/null 2>&1; then
    FZF_DEFAULT_COMMAND=${fzf_fd}
  elif ! command -v fd >/dev/null 2>&1 && command -v rg >/dev/null 2>&1; then
    FZF_DEFAULT_COMMAND=${fzf_rg}
  else
    printf '%s\n' 'Raw fzf.'
  fi
  export FZF_DEFAULT_COMMAND

  export FZF_DEFAULT_OPTS="
    -m
    --style=full
    --bind 'focus:transform-header:file --brief {}'
    # use '?' to toggle file preview
    --preview-window=hidden --bind '?:toggle-preview'
    --preview '([[ -f {} ]] && (${fzf_bat} || cat {})) || ([[ -d {} ]] && (${fzf_eza} | less)) || echo {} 2> /dev/null | head -200'
  "
else
  printf '%s\n' '* Not found: fzf.'
fi

if command -v ledger >/dev/null 2>&1; then
  alias budg='ledger bal ^Asset:Budget'
  alias acc='ledger bal ^Asset:Liquid ^Liability -R'
else
  printf '%s\n' '* Not found: ledger.'
fi

if command -v nvim >/dev/null 2>&1; then
  alias v='nvim'
  alias vi='nvim'
  alias vim='nvim'
else
  printf '%s\n' '* Not found: nvim.'
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
  printf '%s\n' '* Not found: ugrep.'
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
# last {{{1

# starship. keep this at the bottom.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash || true)"
else
  printf '%s\n' '* Not found: starship.'
fi

# ------------------------------------------------------------------------------
# }}}1
