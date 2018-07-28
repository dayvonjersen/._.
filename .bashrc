export GOPATH=~/Desktop/projects/go/gopath
export g=$GOPATH/src/github.com
export PATH=$PATH:$GOPATH/bin
export code=$GOPATH/src/github.com/generaltso
export irc=$code/chopsuey
export game=$HOME/Desktop/code/cyorpg
alias t='python ~/bin/t/t.py --task-dir ~/tasks --list tasks'
source ~/.githelpers
alias gl="pretty_git_log"
alias vim="vim -u NONE --noplugin"
 PROMPT_COMMAND='__git_ps1 "\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[0m\]" " \[\033[01;32m\]\$\[\033[0m\] "'
gg() {
    goimports -w *.go && go build && ./$(basename `pwd`)
}
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
# giving too much of a fuck
stat() {
    git log -1 --pretty="%h %an: %s %cr"
    echo commits: `git shortlog -s | cut -f 1` "|" branches: `git branch --list | wc -l` "|" releases: 0 "|" contributors: 1 "|" memes: Integer overflow. 
    # l
    gocloc --not-match-d .stuff .
}
