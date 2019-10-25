# Git
alias gcb='git town prune-branches'
alias gcm='git checkout master && gupav'

alias st='open -a SourceTree .'
alias gsa='git stash pop'

function gri() { git rebase -i HEAD~"$1"; }            # DANGER: use with caution. pass in the number of commits to go back
function gi() { curl -L -s https://www.gitignore.io/api/\$@ ;} # gi:Generate a gitignore for a given language/environment
function gpu() { git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD); } # quickly create & push local branch on remote

alias git-email='git config --local user.email jasonk92@gmail.com'
