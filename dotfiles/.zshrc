# MacOS config changes
#   TODO: create functions to toggle these values
#   Note: Need to do a "killall Finder" after changing this
# defaults write com.apple.finder CreateDesktop false # Hides desktop icons if "false"
# defaults write com.apple.finder AppleShowAllFiles YES # Show hidden files/directories

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Load all files from ~/.zshrc.d directory
if [ -d $HOME/.zshrc.d ]; then
  for file in $HOME/.zshrc.d/*.zsh; do
    source $file
  done
fi

# Rbenv/Ruby
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Nodenv/Node
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# Python
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# export JAVA_OPTS='-Xms256M -Xmx512M -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:+DoEscapeAnalysis -XX:+UseBiasedLocking -XX:PermSize=64M'

# SBT
export SBT_OPTS="-Xms512M -Xmx1024M -Xss1M -XX:+CMSClassUnloadingEnabled"

# Personal aliases

## Sublime Text Editor
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

## Git
alias gl="git log --graph --pretty=format:'%Cred%h%Creset-%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) <%an>%Creset'"

## Aliases for starting up a quick and dirty web server with ruby or python
## TODO: turn these into functions
export SERVE_PORT=8888
alias ruby-serve="echo '(SERVE_PORT=$SERVE_PORT) ruby -run -e httpd . -p \$SERVE_PORT'; ruby -run -e httpd . -p $SERVE_PORT"
alias python3-serve="echo '(SERVE_PORT=$SERVE_PORT) python3 -m http.server \$SERVE_PORT'; python3 -m http.server $SERVE_PORT"
