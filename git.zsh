alias gcb='gfa && (git branch -vv | grep -q "gone]" && git branch -vv | grep "gone]" | awk '\''{print $1}'\'' | xargs git branch -D || echo "No merged branches to delete.")'
alias gcm='gco $(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@") && gprav && gcb'

alias st='open -a SourceTree .'
alias gsa='git stash pop'

function gri() { git rebase -i HEAD~"$1"; }            # DANGER: use with caution. pass in the number of commits to go back
function gi() { curl -L -s https://www.gitignore.io/api/\$@ ;} # gi:Generate a gitignore for a given language/environment
function gpu() { git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD); } # quickly create & push local branch on remote

alias git-email='git config --local user.email JaKXz@users.noreply.github.com'

