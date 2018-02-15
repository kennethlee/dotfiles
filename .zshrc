# zplug

# check if zplug is installed, download automatically if not
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

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

# ==============================================================================
# spaceship

autoload -Uz promptinit; promptinit
prompt spaceship

SPACESHIP_DIR_COLOR="blue"

SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_HASKELL_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false

SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_BATTERY_SHOW=false

# ==============================================================================
# vimminess

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

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

