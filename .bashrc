# sourcing =====================================================================

# sexy prompt
source ~/.bash_prompt

# enable chruby
source /usr/local/share/chruby/chruby.sh

# auto-switch the current version of Ruby when you cd between your
# different projects
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# neovim =======================================================================

alias vi=nvim
alias vim=nvim

# fzf ==========================================================================

alias fz=fzf

# set ag as default source for fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# extended mode as default
export FZF_DEFAULT_OPTS="-x"

# =====================================

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

# fd - cd to dir of selected file
fd() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# git =================================

# fb - checkout git branch
fb() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

# fco - checkout git commit
fco() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fist - git commit browser
fist() {
  local out sha q
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

# media ===============================

# fp - play song
fp() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && afplay "$file"
}

# misc =========================================================================

# colorize by default
alias tree="tree -C"
alias ls="ls -G"

# other

# kill all background processes
alias crumb="jobs -p | xargs kill -15"

# color ========================================================================

export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Base16 Shell
# favorites: eighties, flat, mocha, monokai, ocean, railscasts, tomorrow,
# twilight
BASE16_SCHEME="eighties"
BASE16_VARIANT="dark"
BASE16_SHELL="$HOME/.base16-shell/base16-$BASE16_SCHEME.$BASE16_VARIANT.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# heroku =======================================================================

### added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# ==============================================================================
