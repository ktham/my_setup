require 'singleton'

class Zsh
  include Singleton

  ZSHRC_FILE = File.join(ENV['HOME'], ".zshrc")

  def provision
    if File.exist?(ZSHRC_FILE) || File.symlink?(ZSHRC_FILE)
      puts "Already installed: oh-my-zsh"
    else
      puts "Installing: oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    end
  end

  def make_default
    if ENV["SHELL"].strip.split("/").last == "zsh"
      puts "Already default shell: zsh"
    else
      puts "Setting default shell: zsh"
      system %Q{chsh -s `which zsh`}
    end
  end

  def rcfile_include(line)
    line = line.strip
    line_exists = File.exist?(ZSHRC_FILE) && File.open(ZSHRC_FILE).each_line.any? { |l| l.include?(line) }
    File.open(ZSHRC_FILE, 'a') { |f| f.puts line } unless line_exists
  end

  def alias(name, command)
    rcfile_include %Q{alias #{name}="#{command}"}
  end

  def export(key, value)
    rcfile_include %Q{export #{key}="#{value}"}
  end

  def export_cmd(key, cmd)
    rcfile_include %Q{export #{key}=$(#{cmd})}
  end

  def add_path(path)
    export "PATH", "#{path.strip}:$PATH"
  end
end
