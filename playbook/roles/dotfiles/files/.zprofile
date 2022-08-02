eval "$(/opt/homebrew/bin/brew shellenv)"

# BEGIN pyenv setting
test -x /opt/homebrew/bin/pyenv && eval "$(/opt/homebrew/bin/pyenv init --path)"
# END pyenv setting