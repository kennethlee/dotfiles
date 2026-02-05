# tools

if ! [ -x "$(command -v bat)" ]; then
  echo "* Not found: bat."
fi

if [ -x "$(command -v eza)" ]; then
  alias ls2="eza -lTag --level=2 --icons=always"
  alias ls3="eza -lTag --level=3 --icons=always"
  alias ls4="eza -lTag --level=4 --icons=always"
else
  echo "* Not found: eza."
fi

if ! [ -x "$(command -v fd)" ]; then
  echo "* Not found: fd."
fi

if ! [ -x "$(command -v rg)" ]; then
  echo "* Not found: rg."
fi

# fzf
if [ -x "$(command -v fzf)" ]; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --bash)"

  alias fz="fzf"

  # feed fzf with fd (if installed); otherwise, with rg.
  bat="bat --style=numbers --color=always {}"
  eza="eza -Tag --icons=always --color=always {}"
  fd="fd --type f --hidden --no-require-git --strip-cwd-prefix"
  rg="rg --files --hidden --no-require-git --follow"
  FZF_DEFAULT_COMMAND=""

  if [ -x "$(command -v fd)" ]; then
    FZF_DEFAULT_COMMAND=$fd
  elif ! [ -x "$(command -v fd)" ] && [ -x "$(command -v rg)" ]; then
    FZF_DEFAULT_COMMAND=$rg
  else
    echo 'Raw fzf.'
  fi
  export FZF_DEFAULT_COMMAND
  # command echo "FZF_DEFAULT_COMMAND=$FZF_DEFAULT_COMMAND"

  export FZF_DEFAULT_OPTS="
    -m
    --style=full
    --bind 'focus:transform-header:file --brief {}'
    # use '?' to toggle file preview
    --preview-window=hidden --bind '?:toggle-preview'
    --preview '([[ -f {} ]] && (${bat} || cat {})) || ([[ -d {} ]] && (${eza} | less)) || echo {} 2> /dev/null | head -200'
  "
else
  echo "* Not found: fzf."
fi

if [ -x "$(command -v ledger)" ]; then
  alias budg='ledger bal ^Asset:Budget'
  alias acc='ledger bal ^Asset:Liquid ^Liability -R'
else
  echo "* Not found: ledger."
fi

if [ -x "$(command -v nvim)" ]; then
  alias v='nvim'
  alias vi='nvim'
  alias vim='nvim'
else
  echo "* Not found: nvim."
fi

# ==============================================================================
# aliases

alias ls="ls -FG"

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

# ==============================================================================
# last

# starship. keep this at the bottom.
if [ -x "$(command -v starship)" ]; then
  eval "$(starship init bash)"
else
  echo "* Not found: starship."
fi
