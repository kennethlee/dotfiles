# tools

# fzf
if [ -x "$(command -v fzf)" ]; then
  # Set up fzf key bindings and fuzzy completion
  source <(fzf --zsh)

  alias fz="fzf"

  # feed fzf with fd (if installed); otherwise, with rg.
  FZF_DEFAULT_COMMAND=""
  fd='fd --type f --strip-cwd-prefix'
  rg=(rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}")
  if [ -x "$(command -v fd)" ]; then
    FZF_DEFAULT_COMMAND=$fd
  elif ! [ -x "$(command -v fd)" ] && [ -x "$(command -v rg)" ]; then
    FZF_DEFAULT_COMMAND="${rg[*]}"
  else
    echo 'Raw fzf.'
  fi
  export FZF_DEFAULT_COMMAND
  # command echo "FZF fed by: $FZF_DEFAULT_COMMAND"

  export FZF_DEFAULT_OPTS="
    -m
    --style=full
    --bind 'focus:transform-header:file --brief {}'
    # use '?' to toggle file preview
    --preview-window=hidden --bind '?:toggle-preview'
    --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  "
else
  echo "* fzf is not installed."
fi

# ledger
if [ -x "$(command -v ledger)" ]; then
  alias budg='ledger bal ^Asset:Budget'
  alias acc='ledger bal ^Asset:Liquid ^Liability -R'
else
  echo "* ledger is not installed."
fi

# nvim
if [ -x "$(command -v nvim)" ]; then
  alias v='nvim'
  alias vi='nvim'
  alias vim='nvim'
else
  echo "* nvim is not installed."
fi

if [ -x "$(command -v tree)" ]; then
  # colorize by default
  alias tree='tree -C'
else
  echo "* tree is not installed."
fi

# ==============================================================================
# bindings

# vim
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# better searching in vim normal mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# after
export KEYTIMEOUT=1

# ==============================================================================
# better search history

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# ==============================================================================
# aliases

alias ls="ls -FG"

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

# ==============================================================================
# last

# starship
eval "$(starship init zsh)"
