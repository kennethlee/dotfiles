# sourcing #####################################################################

# git
source ~/.git-completion.sh
source ~/.git-prompt.sh
source ~/.bash_prompt

# load any supplementary scripts

for config in "$HOME"/.bashrc.d/*.bash ; do
    source "$config"
done
unset -v config

# enable chruby
source /usr/local/share/chruby/chruby.sh

# auto-switch the current version of Ruby when you cd between your
# different projects
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# color ########################################################################

TERM=xterm-256color
NVIM_TUI_ENABLE_TRUE_COLOR=1

# Base16 Shell
# favorites: eighties, flat, mocha, monokai, ocean, railscasts, tomorrow,
# twilight
BASE16_SCHEME="eighties"
BASE16_VARIANT="dark"
BASE16_SHELL="$HOME/.base16-shell/base16-$BASE16_SCHEME.$BASE16_VARIANT.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# heroku #######################################################################

### added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# fzf ##########################################################################

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
