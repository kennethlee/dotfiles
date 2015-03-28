# Aliases ######################################################################

# Neovim
alias vi=nvim
alias vim=nvim

# fzf
alias fz=fzf

# Sourcing #####################################################################

# Git
source ~/.git-completion.sh
source ~/.git-prompt.sh
source ~/.bash_prompt

# Enable chruby
source /usr/local/share/chruby/chruby.sh

# auto-switch the current version of Ruby when you cd between your
# different projects
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Neovim-related ###############################################################

$NVIM_TUI_ENABLE_TRUE_COLOR

# Heroku #######################################################################

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# fzf ##########################################################################

# Set ag as default source for fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash