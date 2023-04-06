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
# sourcing

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# files/dir
alias md='mkdir -p'

# brew
alias brewcl='brew cleanup --prune=all'

# nave / node
alias nd='nave use'

# nvim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ledger
alias budg='ledger bal ^Asset:Budget'
alias acc='ledger bal ^Asset:Liquid ^Liability -R'

# laziness: wholesale update of vim plugins
alias udcol='for i in ~/.local/share/nvim/site/pack/colors/opt/*; do git -C $i pull --ff-only; done'
alias udplug='for i in ~/.local/share/nvim/site/pack/plugins/start/*; do git -C $i pull --ff-only; done'

# fzf
alias fz='fzf'
alias udfz='cd ~/.fzf && git pull --ff-only && ./install && cd -'

# tree: colorize by default
alias tree='tree -C'
alias ls='ls -G'

alias pserv='python -m SimpleHTTPServer 8000'

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

# mongodb
alias mongop='mongod --dbpath ~/db'
