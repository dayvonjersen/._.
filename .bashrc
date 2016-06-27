export GOPATH=~/Desktop/projects/go/gopath
export PATH=$PATH:$GOPATH/bin
alias t='python ~/bin/t/t.py --task-dir ~/tasks --list tasks'
source ~/.githelpers
alias gl="pretty_git_log"
 PROMPT_COMMAND='__git_ps1 "\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[0m\]" " \[\033[01;32m\]\$\[\033[0m\] "'
