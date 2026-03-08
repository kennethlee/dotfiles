# helpers {{{1

has_command() { command -v "$1" >/dev/null 2>&1; }

warn() { printf '%s\n' "$*" >/dev/null 2>&1; }

die() {
  local code=1
  if [ "$1" =~ ^-[0-9]+$ ]; then
    code=${1#-}
    shift
  fi
  printf '%s\n' "$*" >&2
  exit "${code}"
}

# ------------------------------------------------------------------------------
# base {{{1

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
  alias v='nvim'
else
  export EDITOR=vim
fi

# disable bash history
unset HISTFILE

# # bash_history (in case you want it)
# HISTCONTROL=ignoreboth:erasedups
# HISTIGNORE='echo *':'rm *':'rmdir *':'sudo *'
# PROMPT_COMMAND='history -a'

# bash-completion@2 (for Bash 4.2+; use `bash-completion` for older versions)
if type brew >/dev/null 2>&1; then
  # shellcheck disable=2154
  if [ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]; then
    # shellcheck disable=1091
    . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      # shellcheck disable=1090
      [ -r "${COMPLETION}" ] && . "${COMPLETION}"
    done
  fi
fi

# ------------------------------------------------------------------------------
# aliases / keys {{{1

# HANDY SHORTCUTS:
# Ctrl-r: search command history (via an fzf search, in my case)
# Ctrl-l: clear screen except anything unexecuted in current line.

# kill all background processes
alias crumb='jobs -p | xargs kill -15'

# -O: --remote-name
# -L: --location
# -f: --fail
alias colf='curl -OLf'

alias ls='ls -FG'
# decent native substitute for eza.
alias ll="ls -GHhl -D '%FT%T'"

# print all env vars PLUS shell vars
alias printsh='(set -o posix ; set) | less'

alias vb='v ~/.bashrc'
alias vv='v ~/.config/nvim/init.lua'

has_command 'eza' || warn 'eza not found'
alias e1='eza -lTag --level=1 --icons=always --time-style=long-iso'
alias e2='eza -lTag --level=2 --icons=always --time-style=long-iso'
alias e3='eza -lTag --level=3 --icons=always --time-style=long-iso'
alias e4='eza -lTag --level=4 --icons=always --time-style=long-iso'

has_command 'ledger' || warn 'ledger not found'
alias budg='ledger bal ^Asset:Budget'
alias acc='ledger bal ^Asset:Liquid ^Liability -R'

has_command 'ugrep' || warn 'ugrep not found'
alias ugrep='ugrep --smart-case'
# -R: --dereference-recursive
# -I: --ignore-binary
# -n: --line-number
# -k: --column-number
# -j: --smart-case
# -u: --ungroup
alias lg='ugrep -RInk -j -u --hidden --ignore-files --tabs=1'

# ------------------------------------------------------------------------------
# commands {{{1

has_command 'fd' || warn 'fd not found'

load_config_fzf() {
  alias fz='fzf'
  # Unset FZF_CTRL_T_COMMAND + set up fzf key bindings and fuzzy completion
  FZF_CTRL_T_COMMAND='' eval "$(fzf --bash || true)"

  local fzf_fd='fd --type f --hidden --no-require-git --strip-cwd-prefix'
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="${fzf_fd}"
  fi

  local fzf_bat='bat --style=numbers --color=always --theme=base16 {}'
  local fzf_eza='eza -Tag --icons=always --color=always {}'
  export FZF_DEFAULT_OPTS="
    -m
    --style=full
    --bind 'focus:transform-header:file --brief {}'
    # use '?' to toggle file preview
    --preview-window=hidden --bind '?:toggle-preview'
    --preview '([[ -f {} ]] && (${fzf_bat} || cat {})) || ([[ -d {} ]] && (${fzf_eza} | less)) || echo {} 2> /dev/null | head -200'
  "
}
if has_command 'fzf'; then load_config_fzf; fi

# starship. keep this at the bottom.
eval "$(starship init bash || true)"

# ------------------------------------------------------------------------------
# }}}1
