require_relative 'lib/brew'
require_relative 'lib/file_util'
require_relative 'lib/jar'
require_relative 'lib/npm'
require_relative 'lib/rbenv'
require_relative 'lib/zsh'

# singleton support objects
brew = Brew.instance
jar = Jar.instance
rbenv = Rbenv.instance
zsh = Zsh.instance
file_util = FileUtil.instance

# Install Homebrew
brew.provision

# Homebrew taps
brew.tap 'caskroom/cask'
brew.tap 'caskroom/versions'
brew.tap 'homebrew/dupes'
brew.tap 'homebrew/science'

# Update formulas
brew.update

# Upgrade existing packages
brew.upgrade

# Common dependencies
brew.install 'imagemagick'
brew.install 'gcc' # contains gfortran, which is required for SciPy, R
brew.install 'openssl'

# Useful dev utilities
brew.install 'git' # source control
brew.install 'grep' # gnu grep is better than bsd grep on the mac
brew.install 'htop-osx' # view system stats
brew.install 'jq' # JSON utility
brew.install 'phantomjs' # headless webkit tool
brew.install 'tmux' # terminal multiplexer
brew.install 'vim' # text editor

# Python
brew.install 'python'
system 'pip install -r pip_requirements.txt'

# Ruby
brew.install 'rbenv' # ruby version manager
brew.install 'ruby-build' # ruby installer/builder
brew.install 'rbenv-gem-rehash' # automatic put gems onto PATH
rbenv.install('2.1.3')
rbenv.global('2.1.3')

# Node
brew.install 'node'
npm.install 'bower'

# Java & Scala
brew.cask_install 'java' # Installs the latest jdk (e.g. '8u25-b17')
brew.install 'scala'
brew.install 'sbt'

# R
brew.install 'r'
# I've opted to try out Revolution R Open which integrates Intel's BLAS libraries (http://mran.revolutionanalytics.com/download/#download)

# R_BREW_INSTALLATION = "/usr/local/opt/r/R.framework"
# if File.exist?(R_BREW_INSTALLATION) && !File.symlink?(R_BREW_INSTALLATION, "/Library/Frameworks")
#   puts "Found R Installation."
#   puts "Symlinking '#{R_BREW_INSTALLATION}' to '/Library/Frameworks'"
#   File.symlink(R_BREW_INSTALLATION, "/Library/Frameworks")  
# end

brew.cask_install 'rstudio'

# Useful Jars
jar.download('http://archive.apache.org/dist/avro/avro-1.7.7/java/avro-tools-1.7.7.jar')

# Dotfiles
file_util.symlink('dotfiles/.vimrc', '~/.vimrc')
file_util.symlink('dotfiles/.zshrc', '~/.zshrc')

# Zsh
zsh.provision
zsh.make_default

brew.cask_install 'android-file-transfer'
brew.cask_install 'caffeine'
brew.cask_install 'dropbox'
brew.cask_install 'eloquent'
brew.cask_install 'firefox'
brew.cask_install 'google-chrome'
brew.cask_install 'google-drive'
brew.cask_install 'google-hangouts'
brew.cask_install 'intellij-idea'
brew.cask_install 'iterm2'
brew.cask_install 'flux'
brew.cask_install 'rubymine'
brew.cask_install 'screenhero'
brew.cask_install 'skype'
brew.cask_install 'smcfancontrol'
brew.cask_install 'sourcetree'
brew.cask_install 'vlc'
brew.cask_install 'wechat'

# Remove old versions
brew.cleanup
