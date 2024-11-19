alias cat='bat'                             # colorized (syntax highlighted) cat
alias dec='dev'
alias ping='prettyping'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias l='ll'                                # Preferred 'ls' implementation
alias ll='eza -labh --git --no-permissions --octal-permissions'
alias ls='eza -a'
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -a'                       # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths

function port() { lsof -t -i:"$1"; }
function mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
function trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
function ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview

alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias sp='sudo purge'

function t() {
  # Defaults to 3 levels deep, do more with `t 5` or `t 1`
  # pass additional args after
  tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -aC $2
}
