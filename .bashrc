# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ssh crap
if [[ "$SSH_AGENT_PID" = "" ]]; then
    eval $(ssh-agent -s) > /dev/null
    export SSH_AGENT_PID
fi
ssh-add -l 2>&1 >/dev/null
if [[ $? -eq 1 ]]; then
    ssh-add "$HOME/.ssh/id_rsa"
fi

# history
shopt -s histappend
HISTCONTROL=ignoredups
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="clear:cls:history:reset"

# keep LINES and COLUMNS up-to-date
shopt -s checkwinsize

#
# go
#

# include go tools in PATH if they aren't there already
if [[ ! $(which go) ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi
export GOROOT=/usr/local/go/

# pretty-print panic tracebacks
# github.com/maruel/panicparse
export GOTRACEBACK=all
panicparse() {
    last=$(echo `history | tail -n2 | head -n1` | sed 's/[0-9]* //')
    $last |& pp
}

#
# h a c k s
#

# ** this is a fix for broken behavior **
# ** with standard disributions of vim **
# ** arising from incompatibilities    **
# ** with configuration and plugins    **
alias vim="vim -u NONE -U NONE -N"
# ** install neovim on new systems     **

#
# i n c l u d e s
#

. /usr/share/bash-completion/bash_completion
if [[ $? == 1 ]] ; then 
    sudo apt-get install bash-completion
fi

# various autocompletes
. ~/apt-autocomplete.sh
. ~/git-autocomplete.sh

# switch to previous directories with ease
# github.com/rupa/z
. ~/z/z.sh

# custom prompt with git integration, used instead of PS1=
. ~/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
#GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
# this prompt is made to look like gentoo's
if [[ ${EUID} == 0 ]] ; then
    PROMPT_COMMAND='__git_ps1 "\[\033[01;31m\]\h\[\033[01;34m\] \W\[\033[0m\]" " \[\033[01;31m\]#\[\033[0m\] "'
else
    PROMPT_COMMAND='__git_ps1 "\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[0m\]" " \[\033[01;32m\]\$\[\033[0m\] "'
fi

#
# a l i a s e s
#

# SICK OF IT
murder() {
    # usage: murder 
    ps -aux | grep $1 | awk '{print $2}' | xargs kill -9
}

# incredibly useful todo app
# github.com/sjl/t
alias t='python ~/t/t.py --task-dir ~/tasks --list tasks'

# rice
alias ls='ls --color=always'
# I don't know where this came from but it's useful af
alias colors="~/colortest1.sh"

# xkcd.com/1168
alias untar='tar -xvf'
alias untgz='tar -xzvf'
alias tgz='tar -czvf'

# this is useful to prevent swaping on systems without a lot of RAM
alias memcacheclear='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'

# pygmentize does syntax highlighting in the terminal
# sudo apt install python-pygments
pyg() {
    pygmentize $1 | less -R
}

# check javascript files for syntax errors
# sudo npm install -g acorn
lint() {
    acorn --silent $1
    if [[ $? -eq 0 ]]; then
        echo -ne "\033[32mNo syntax errors.\033[0m\n"
    fi
}

# these let you start/stop/restart and check the status of your LAMP stack
alias lamp="sudo service apache2 start; sudo service mysql start"
alias unlamp="sudo service apache2 stop; sudo service mysql stop"
alias relamp="sudo service apache2 restart;" 
# sudo service mysql restart"
alias lampstat="sudo service apache2 status; sudo service mysql status"

#
# git
#

# log in compact, single-line format useful to pipe into wc -l
alias gitlog="git --no-pager log --pretty=format:'%h %ar %s'"

# status in compact, single-line format
alias gitstatus="git status -s"

# ignore all currently unstaged files
gitignore() {
    dest=".git/info/exclude"
    if [[ $1 == "--save" ]]; then
        dest=".gitignore"
    fi
    git ls-files --other --exclude-standard >> $(git rev-parse --show-toplevel)/$dest
}

# no fucks given
gitcommit() {
    git add .
    if [[ $1 ]]; then
        msg=$(echo $@)
        git commit -m "$msg"
    else
        git commit --allow-empty-message -m ''
    fi
}

# when git pull just isn't enough
gitfetch() {
    git branch -a | grep -v HEAD | perl -ne 'chomp($_); s|^\*?\s*||; if (m|(.+)/(.+)| && not $d{$2}) {print qq(git branch --track $2 $1/$2\n)} else {$d{$_}=1}' | csh -xfs
    git fetch --all
}

#
# r00t
#
if [[ $UID -eq 0 ]]; then 
    export PATH=$PATH:/sbin
fi

#
# common
#
if [[ $HOSTNAME = "chopstick" || $HOSTNAME = "wok" ]] ; then
    # bittorrent sync
    # getsync.com
    if [[ ! $(pidof btsync) ]]; then
        ./btsync
    fi
    
    # github.com/KittyKatt/screenFetch
    alias cls='reset; screenfetch; read -n 1 2>/dev/null >/dev/null; reset'
fi

#
# wok
#
if [[ $HOSTNAME = "wok" ]] ; then
    export GOPATH=/go
    export PATH=$PATH:$GOPATH/bin
fi

#
# chopstick
#
if [[ $HOSTNAME = "chopstick" ]] ; then
    # github.com/pipeseroni/pipes.sh
    alias pipes="~/pipes.sh/pipes.sh"

    # windows filesharing, for my music collection
    alias winfs="sudo mount.cifs //192.168.1.2/Music /home/tso/Desktop/Music -o user=Leek; sudo mount.cifs //192.168.1.2/what /home/tso/what -o user=Leek"
    alias unwinfs="sudo umount -a -t cifs -l"

    # the equivalent of Everything file search for windows, highly recommended
    # github.com/DoTheEvo/ANGRYsearch
    alias angrysearch='python3 /usr/share/angrysearch/angrysearch.py &'

    # iceweasel a shit
    localfox() { 
        /opt/firefox/firefox-bin http://[::1]/$1 &
    }
    alias firefox="/opt/firefox/firefox-bin"

    # I've yet to standardize on a place to put $GOPATH ...
    export GOPATH="/home/tso/gocode"
    export PATH=$PATH:$GOPATH/bin

    # nvm (node version manager)
    export NVM_DIR="/home/tso/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  

    # rvm (ruby version manager)
    export PATH="$PATH:$HOME/.rvm/bin"
fi
