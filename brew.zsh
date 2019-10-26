# Homebrew shortcuts
brewinfo() { brew info "$1"; brew desc "$1"; }         # get all information on a brew package
brewsearch() { brew search "$1"; brew desc -s "$1"; }  # thorough search for brew packages
alias bu='brew update && brew upgrade && brew cleanup'
alias bp='brew cleanup --prune-prefix && brew doctor'
