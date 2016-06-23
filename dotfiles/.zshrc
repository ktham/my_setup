# Hides desktop icons if "false"
# Need to do a "killall finder" after changing this
# defaults write com.apple.finder CreateDesktop false

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Python
export PATH="/usr/local/share/python:$PATH"

# Rbenv/Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# android
export PATH="/Users/kevin.tham/adt-bundle-mac-x86_64-20140702/sdk/platform-tools:$PATH"

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# export JAVA_OPTS='-Xms256M -Xmx512M -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:+DoEscapeAnalysis -XX:+UseBiasedLocking -XX:PermSize=64M'

# rJava
# R CMD javareconf JAVA_CPPFLAGS="-I/System/Library/Frameworks/JavaVM.framework/Headers -I/Library/Java/JavaVirtualMachines/$(ls /Library/Java/JavaVirtualMachines/ | sort -r | head -1)/"

# SBT
export SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"

# Postgresapp
# Note: Install from: http://postgresapp.com/
export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

# App aliases
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Aliases for starting up a quick and dirty web server with ruby or python
export SERVE_PORT=8888
alias ruby-serve="echo '(SERVE_PORT=$SERVE_PORT) ruby -run -e httpd . -p \$SERVE_PORT'; ruby -run -e httpd . -p $SERVE_PORT"
alias python2-serve="echo '(SERVE_PORT=$SERVE_PORT) python -m SimpleHTTPServer \$SERVE_PORT'; python -m SimpleHTTPServer $SERVE_PORT"
alias python3-serve="echo '(SERVE_PORT=$SERVE_PORT) python3 -m http.server \$SERVE_PORT'; python3 -m http.server $SERVE_PORT"

# JAR aliases
alias avro-tools="java -jar ~/my_setup/jars/$(ls ~/my_setup/jars | grep avro-tools | sort | tail -n 1)"

# Other useful personal aliases
alias cdc="cd $HOME/Code"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset-%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) <%an>%Creset'"
