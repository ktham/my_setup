require 'singleton'

class Git
  include Singleton

  def config(key, value)
    cmd = "git config --global #{key}"
    if `#{cmd} | grep #{value}`.empty?
      puts "Executing: git config --global #{key} #{value}"
      system "git config --global #{key} #{value}"
    end
  end

end
