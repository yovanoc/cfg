export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export PATH=$HOME/Documents/code/flutter/flutter/bin:$PATH

export PATH=/usr/local/opt/curl/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
export MY_NAME="Christopher Yovanovitch"
export MY_EMAIL="yovano_c@outlook.com"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

ZSH_THEME="spaceship"

plugins=(git tig docker docker-compose golang pip)
plugins+=( history history-substring-search httpie sudo vagrant postgres )
plugins+=( osx lein node npm jump gulp mosh )
plugins+=( k z alias-tips zsh-completions zsh-autosuggestions )
plugins+=( zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh
source ~/.cargo/env
source <(kompose completion zsh)

DEFAULT_USER=devchris

## ALIAS
alias c="code-insiders ."
alias kk="clear"
alias wip="git add . && git commit -m 'wip' && git push"
alias up="brew update && brew upgrade && rustup update && upnode && npmg gitmoji-cli lerna"
alias upnode="NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/release && nvm install node"
alias upnoden="NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly && nvm install node"
alias rmnode="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias rmdist="find . -name 'dist' -type d -prune -exec rm -rf '{}' +"
alias rmstore="find . -name '.DS_Store' -type f -delete"
alias rmts="find . -name 'tsconfig.tsbuildinfo' -type f -delete"
alias rmall="rmnode && rmdist && rmstore && rmts";
alias reyarn="rm -rf yarn.lock node_modules/ && yarn"
alias ez="code-insiders $HOME/.zshrc"
alias server="python -m SimpleHTTPServer"
alias dkps="docker ps"
alias dkst="docker stats"
alias dkpsa="docker ps -a"
alias dkimgs="docker images"
alias dkcpup="docker-compose up -d"
alias dkcpdown="docker-compose down"
alias dkcpstart="docker-compose start"
alias dkcpstop="docker-compose stop"
alias dk-clean-unused='docker system prune --all --force --volumes'
alias dk-clean-all='docker stop $(docker container ls -a -q) && docker system prune -a -f --volumes'
alias dk-clean-containers='docker container stop $(docker container ls -a -q) && docker container rm $(docker container ls -a -q)'
alias kb="kubectl"
alias mk="minikube"
alias ssh-tor='torsocks ssh'
alias vlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias s="${HOME}/Documents/code/nodejs/lazyspace/scripts"
alias nd="node packages/dofustouch/dist/dofustouch.js"
alias pnd="NO_PLANIF=true nd"
alias todedie7="scp packages/dofustouch/dist/dofustouch.js dedie7:/home/desktop/dofustouch.js"
alias todedie8="scp packages/dofustouch/dist/dofustouch.js dedie8:/home/desktop/dofustouch.js"
alias todedie10="scp packages/dofustouch/dist/dofustouch.js dedie10:/home/desktop/dofustouch.js"
alias tokt="scp packages/dofustouch/dist/dofustouch.js kt:/home/desktop/dofustouch.js"
alias todedie="todedie7 && todedie8 && todedie10 && tokt"
alias totest="scp packages/dofustouch/dist/dofustouch.js dedie10:/home/desktop/dofustouch_test.js"
alias cloud="cd /Users/devchris/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias nosyncall="find . -name node_modules -exec 'nosync "$0"' {} \;"

nosync () {
    cd $PWD;
    folder=$(basename "$PWD");
    newfolder="$folder.nosync.noindex";
    cd ..;
    mv $folder $newfolder;
    ln -s $newfolder $folder;
    cd $folder;
}

## GIT
GIT_AUTHOR_NAME=$MY_NAME
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL=$MY_EMAIL
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global core.editor "code-insiders --wait"
git config --global commit.gpgSign true
git config --global tag.gpgSign true

## NPM
npm set init.author.email $MY_EMAIL
npm set init.author.name $MY_NAME
npm set init.license "MIT"

## Go
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

## CUSTOM FUNCTIONS

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# Git clone + yarn
function gcn {
    url=$1;
    if [ -n "${1}" ]; then
        echo 'OK'
    else
        echo 'Koooooooooooooooo'
    fi
    cd ~/Documents/code;
    reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
    git clone $url $reponame;
    cd $reponame;
    yarn;
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/devchris/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/devchris/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/devchris/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/devchris/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export CELESTIS_TOKEN=Y2tudmQwNzVmMDAwMXk0YzJ0aWQ3OHViMA.NDE0MDg3NzI.KBxuuHYhVCIk4QNddr+O+UQcTnkGXe7+kB2+yioFsC0
export CELESTIS_DEV_TOKEN=Y2tudmQwNzVmMDAwMXk0YzJ0aWQ3OHViMA.NDE0MDg3NzI.KBxuuHYhVCIk4QNddr+O+UQcTnkGXe7+kB2+yioFsC0

gcur () {
    git stash && git co dev && git pull && git checkout - && git rebase dev && git stash pop
}


gnew () {
    git stash && git co dev && git pull && git checkout -b $1 && git stash pop && git add . && git commit
}

gpr () {
    git push && git pull-request
}

function ka(){
    cnt=$( p $1 | wc -l)  # total count of processes found
    klevel=${2:-15}       # kill level, defaults to 15 if argument 2 is empty
    
    echo -e "\nSearching for '$1' -- Found" $cnt "Running Processes .. "
    p $1
    
    echo -e '\nTerminating' $cnt 'processes .. '
    
    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -klevel
    echo -e "Done!\n"
    
    echo "Running search again:"
    p "$1"
    echo -e "\n"
}

function p() {
    ps aux | grep -i $1 | grep -v grep
}

function newkey() {
    key=~/.ssh/$1
    ssh-keygen -f $key
    ssh-add -K $key
    ssh-copy-id -i $key $2
}

eval "$(starship init zsh)"
export PATH="/usr/local/sbin:$PATH"

export GPG_TTY=$(tty)
gpgconf --launch gpg-agentalias config='/usr/bin/git --git-dir=/Users/devchris/.cfg/ --work-tree=/Users/devchris'
