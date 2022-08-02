alias ll="ls -lG"
alias la="ls -aG"
alias lla="ls -laG"
alias ltr="ls -ltrG"
alias gi="git init"
alias gs="git status"
alias ga="git add"
alias gd="git checkout development"
alias gp="git pull -p"
alias gc="git checkout"
alias gcm="git commit -m"
alias chrome="open -a '/Applications/Google Chrome.app'"
alias saml="saml2aws login -a gsuite --skip-prompt --role='arn:aws:iam::1234567890:role/GSuiteAdmin'"
alias memo="code ~/work/memo/memo_`date "+%Y%m%d_%H%M%S"`.md"
alias blog="${HOME}/work/self-project/blog/kzk-blog/bin/create_post.sh"

# Get Global IP Address
alias gip="curl inet-ip.info"

# for Android Studio
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

# for Anaconda
export PATH=$HOME/anaconda3/bin:$PATH

# for Rust
export PATH=$HOME/.cargo/bin:$PATH

# for Node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# TypeScript
export PATH=$PATH:`npm bin -g`

# for go
# export GOROOT=$(go1.18 env GOROOT)
# export PATH=${GOROOT}/bin:${PATH}
# export GOPATH=$HOME/go

# BEGIN pyenv setting
test -x /opt/homebrew/bin/pyenv && eval "$(/opt/homebrew/bin/pyenv init -)"

# BEGIN nodenv setting
test -x /opt/homebrew/bin/nodenv && eval "$(/opt/homebrew/bin/nodenv init -)"

# for Java
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home

# GDAL
export GDAL_LIBRARY_PATH=/usr/local/opt/gdal/lib/libgdal.31.dylib
export GEOS_LIBRARY_PATH=/usr/local/opt/geos/lib/libgeos.3.10.3.dylib

# eksctl
fpath=($fpath ~/.zsh/completion)

# 補完機能
autoload -U compinit
compinit

# ruby version
# eval "$(rbenv init -)"
# export PATH="$HOME/.rbenv/shims:$PATH"

# VCSの情報を取得するzsh関数
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }

# プロンプト（左）
# PROMPT='%{$fg[green]%}[%n@%m]%{$reset_color%}'
PROMPT='%{$fg[green]%}% %D %* %{$reset_color%}'
PROMPT=$PROMPT'%{${fg[yellow]}%}%}%~ %{${reset_color}%} ${vcs_info_msg_0_} 
%{$reset_color%}%{${fg[yellow]}%}%}> '

# プロンプト（右）
# RPROMPT='%{${fg[red]}%}[%~]%{${reset_color}%}'
# precmd () {
RPROMPT="%{%(?.$fg[green].$fg[red])%}% 乁( ˙ω˙ )厂 %{$reset_color%}"
# }

# auto suggestion
. ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# -------- zplug設定 ----------
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi
# add plugin
source /usr/local/opt/zplug/init.zsh
zplug "mollifier/cd-gitroot" &>/dev/null 2>&1
zplug "b4b4r07/enhancd", use:init.sh &>/dev/null 2>&1
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3" &>/dev/null 2>&1
zplug "zsh-users/zsh-syntax-highlighting", defer:2 &>/dev/null 2>&1
zplug "zsh-users/zsh-completions" &>/dev/null 2>&1
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf &>/dev/null 2>&1

# Rename a command with the string captured with `use` tag
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# -----------------------------

# env
export PATH=${HOME}/Library/Python/3.7/bin/:~/.nodebrew/current/bin/:$PATH

# motd
cat ~/.motd/motd.txt

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${HOME}/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/anaconda3/etc/profile.d/conda.sh" ]; then
        . "${HOME}/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '${HOME}/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '${HOME}/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq "$@"
}

