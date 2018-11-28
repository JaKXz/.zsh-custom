function chrome-app() {
  open -na "Google Chrome" --args "--app=$1"
}

alias twitter='chrome-app 'https://mobile.twitter.com''
# alias twitter='open -na "Google Chrome" --args "--app=https://mobile.twitter.com"'
