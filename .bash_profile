# general {{{1

source ~/.bashrc

# git completion (brew)
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# ==============================================================================
# chruby {{{1

# set default ruby
chruby ruby-2.2.2

# ==============================================================================
# }}}1
