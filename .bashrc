# sourcing #####################################################################

# git
source ~/.git-completion.sh
source ~/.git-prompt.sh
source ~/.bash_prompt

# enable chruby
source /usr/local/share/chruby/chruby.sh

# auto-switch the current version of Ruby when you cd between your
# different projects
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# color ########################################################################

NVIM_TUI_ENABLE_TRUE_COLOR=1
TERM=xterm-256color

# heroku #######################################################################

### added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Load any supplementary scripts ###############################################

for config in "$HOME"/.bashrc.d/*.bash ; do
    source "$config"
done
unset -v config

# fzf ##########################################################################

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
