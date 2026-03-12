eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
fi
