require 'singleton'

class Pyenv
  include Singleton

  def install(version)
    if `pyenv versions | grep #{version}`.empty?
      puts "Installing: python #{version}"

      # On MacOS Mojave and higher, need to add sdk spath: https://github.com/pyenv/pyenv/issues/1219
      # After https://github.com/pyenv/pyenv/pull/1274/ is merged, can remove the below CFLAGS var
      if system "CFLAGS=\"-I$(xcrun --show-sdk-path)/usr/include\" pyenv install #{version}"
        puts "Installed: python #{version}"
      else
        puts "Error Installing: python #{version}"
      end
    else
      puts "Already installed: python #{version}"
    end
  end

  def global(version)
    if `pyenv global | grep #{version}`.empty?
      puts "Setting python #{version} as the globally default python version"
      system "pyenv global #{version}"
    else
      puts "found python #{version} as globally default python version"
    end
  end

  def installed?
    !`which pyenv`.empty?
  end
end
