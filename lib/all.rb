require_relative 'brew'
require_relative 'file_util'
require_relative 'git'
require_relative 'jar'
require_relative 'pyenv'
require_relative 'nodenv'
require_relative 'rbenv'
require_relative 'zsh'

def brew() Brew.instance end
def file_util() FileUtil.instance end
def git() Git.instance end
def nodenv() Nodenv.instance end
def pyenv() Pyenv.instance end
def rbenv()Rbenv.instance end
def zsh()Zsh.instance end
