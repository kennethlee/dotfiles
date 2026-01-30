# colors

TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# ==============================================================================
# zplug

# check if zplug is installed, download automatically if not
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "BrandonRoehl/zsh-clean", use:clean.plugin.zsh, from:github, as:theme

zplug load

# ==============================================================================
# fzf

source <(fzf --zsh)

# feed fzf with fd (if installed); otherwise, with rg.
FZF_DEFAULT_COMMAND=""
fd='fd --type f --strip-cwd-prefix'
rg='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}"'
if [ -x "$(command -v fd)" ]; then
  FZF_DEFAULT_COMMAND=$fd
elif ! [ -x "$(command -v fd)" ] && [ -x "$(command -v rg)" ]; then
  FZF_DEFAULT_COMMAND=$rg
else
  echo 'Raw fzf.'
fi
export FZF_DEFAULT_COMMAND
# command echo "FZF fed by: $FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="-m --inline-info --style=full
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind '?:toggle-preview'
"

alias fz="fzf\
  --style full\
  --preview 'fzf-preview.sh {}'\
  --bind 'focus:transform-header:file\
  --brief {}'"

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
# vim

# cursor: block for normal mode, i-beam for insert mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $2 = "block" ]]; then
    echo -ne "\e[2 q"
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $2 = "beam" ]]; then
    echo -ne "\e[6 q"
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}

zle -N zle-line-init
echo -ne "\e[6 q" # Use beam shape cursor on startup.
preexec() { echo -ne "\e[6 q" ;} # Use beam shape cursor for each new prompt.

# ==============================================================================
# aliases

# nvim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ledger
alias budg='ledger bal ^Asset:Budget'
alias acc='ledger bal ^Asset:Liquid ^Liability -R'

# tree: colorize by default
alias tree='tree -C'
alias ls='ls -G'

# kill all background processes
alias crumb='jobs -p | xargs kill -15'
