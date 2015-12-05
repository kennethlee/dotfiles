# general ======================================================================

source ~/.bashrc

# git tab completion (homebrew)
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# default ruby =================================================================

chruby ruby-2.2.2
