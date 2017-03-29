require 'singleton'

class Nodenv
  include Singleton

  def install(version)
    if `nodenv install -l | grep #{version}`.empty?
      puts "Installing: node #{version}"
      if system "nodenv install #{version}"
        puts "Installed: node #{version}"
      else
        puts "Error Installing: node #{version}"
      end
    else
      puts "Already installed: node #{version}"
    end
  end

  def global(version)
    if `nodenv global | grep #{version}`.empty?
      puts "Setting node #{version} as the globally default node version"
      system "nodenv global #{version}"
    else
      puts "found node #{version} as globally default node version"
    end
  end

  def installed?
    !`which nodenv`.empty?
  end
end
