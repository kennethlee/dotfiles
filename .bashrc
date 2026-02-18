# commands {{{1

if ! command -v bat >/dev/null 2>&1; then
  printf '%s\n' '* Not found: bat.'
fi

if command -v eza >/dev/null 2>&1; then
  alias z1='eza -lTag --level=1 --icons=always --time-style=long-iso'
  alias z2='eza -lTag --level=2 --icons=always --time-style=long-iso'
  alias z3='eza -lTag --level=3 --icons=always --time-style=long-iso'
  alias z4='eza -lTag --level=4 --icons=always --time-style=long-iso'
else
  printf '%s\n' '* Not found: eza.'
fi

if ! command -v fd >/dev/null 2>&1; then
  printf '%s\n' '* Not found: fd.'
fi

if ! command -v rg >/dev/null 2>&1; then
  printf '%s\n' '* Not found: rg.'
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --bash)"

  alias fz='fzf'

  # feed fzf with fd (if installed); otherwise, with rg.
  bat='bat --style=numbers --color=always --theme=base16 {}'
  eza='eza -Tag --icons=always --color=always {}'
  fd='fd --type f --hidden --no-require-git --strip-cwd-prefix'
  rg='rg --files --hidden --no-require-git --follow'
  FZF_DEFAULT_COMMAND=''

  if command -v fd >/dev/null 2>&1; then
    FZF_DEFAULT_COMMAND=${fd}
  elif ! command -v fd >/dev/null 2>&1 && command -v rg >/dev/null 2>&1; then
    FZF_DEFAULT_COMMAND=${rg}
  else
    printf '%s\n' 'Raw fzf.'
  fi
  export FZF_DEFAULT_COMMAND
  # printf '%s\n' "FZF_DEFAULT_COMMAND=${FZF_DEFAULT_COMMAND}"

  export FZF_DEFAULT_OPTS="
    -m
    --style=full
    --bind 'focus:transform-header:file --brief {}'
    # use '?' to toggle file preview
    --preview-window=hidden --bind '?:toggle-preview'
    --preview '([[ -f {} ]] && (${bat} || cat {})) || ([[ -d {} ]] && (${eza} | less)) || echo {} 2> /dev/null | head -200'
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

# ------------------------------------------------------------------------------
# aliases {{{1

alias ls='ls -FG'

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

# ------------------------------------------------------------------------------
# last {{{1

# starship. keep this at the bottom.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
else
  printf '%s\n' '* Not found: starship.'
fi

# ------------------------------------------------------------------------------
# }}}1
