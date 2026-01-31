# fzf

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

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

export FZF_DEFAULT_OPTS="-m --inline-info --style=full
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind '?:toggle-preview'
"

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

# fzf
alias fz="fzf"

# ledger
alias budg='ledger bal ^Asset:Budget'
alias acc='ledger bal ^Asset:Liquid ^Liability -R'

# nvim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# tree: colorize by default
alias tree='tree -C'
alias ls='ls -G'

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

# ==============================================================================
# last

# starship
eval "$(starship init zsh)"
