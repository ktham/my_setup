require 'singleton'

class Brew
  include Singleton

  def provision
    if File.exist?('/usr/local/bin/brew')
      puts 'Already installed: homebrew'
    else
      puts 'Installing homebrew...'
      system %Q{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
    end
  end

  def cleanup
    system('brew cleanup')
  end

  def update
    puts 'Updating homebrew formulas'
    system('brew update')
  end

  def upgrade
    puts 'Updating homebrew-installed packages'
    system('brew upgrade')
  end

  @existing_taps = nil
  def tap(source)
    @existing_taps ||= `brew tap`.split("\n")
    if !@existing_taps.include?(source)
      puts "Adding #{source} to brew taps"
      if system("brew tap #{source}")
        @existing_taps << source
      end
    end
  end

  @existing_packages = nil
  def install(package)
    @existing_packages ||= `brew list`.split("\n")
    if !@existing_packages.include?(package)
      puts "Installing #{package}"
      if system("brew install #{package}")
        @existing_packages << package
      end
    end
  end
  
  @existing_cask_packages = nil
  def cask_install(package)
    @existing_cask_packages ||= `brew cask list`.split("\n")
    if !@existing_cask_packages.include?(package)
      puts "Installing: #{package}"
      if system("brew cask install #{package}")
        @existing_cask_packages << package
      end
    else
      puts "Already installed: #{package}"
    end
  end
end
