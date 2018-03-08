# zplug

# check if zplug is installed, download automatically if not
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "olivierverdier/zsh-git-prompt", use:zshrc.sh, hook-build:"zplug clear"
# zplug "BrandonRoehl/zsh-clean", use:clean.zsh, from:github, as:theme

zplug load

# ==============================================================================
# sourcing

# enable chruby
source /usr/local/share/chruby/chruby.sh

# auto-switch the current version of Ruby when you cd between your different
# projects
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zsh-git-prompt
source ~/.zplug/repos/olivierverdier/zsh-git-prompt/zshrc.sh

# work-around to enable use of <C-r>/<C-t> when using fzf in term window
# https://github.com/junegunn/fzf/issues/809
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

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
function zle-keymap-select zle-line-init {
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish {
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# prompt
# PROMPT='%B[%n@%m]%b %~ $(git_super_status) %# '
PROMPT='%B[%n@%m]%b %~$(git_super_status) %# '

# ==============================================================================
# aliases

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# files/dir
alias md='mkdir -p'

# nvim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# laziness: wholesale update of vim plugins
alias udpacks='for i in ~/.config/nvim/pack/bundle/start/*; do git -C $i pull; done'
alias udpacko='for i in ~/.config/nvim/pack/bundle/opt/*; do git -C $i pull; done'

# fzf
alias fz='fzf'
alias udfz='cd ~/.fzf && git pull && ./install && cd -'

# rails/bundler
alias r='rails'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias dbc='rake db:create'
alias dbm='rake db:migrate'
alias dbs='rake db:seed'
alias dbd='rake db:drop'

# tree: colorize by default
alias tree='tree -C'
alias ls='ls -G'

alias pserv='python -m SimpleHTTPServer 8000'

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

# mongodb
alias mongop='mongod --dbpath ~/db'

# ==============================================================================
# color

export NVIM_TUI_ENABLE_TRUE_COLOR=1

# ==============================================================================
# misc

# added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# export PATH="~/mongodb/bin:$PATH"
export PATH=~/mongodb/bin:$PATH
