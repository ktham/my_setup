{ username, homeDirectory}:
  { config, pkgs, ... }:
    {
      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      home.username = username;
      home.homeDirectory = homeDirectory;

      # Packages that should be installed to the user profile.
      home.packages = [
        pkgs.zsh-powerlevel10k # custom theme for oh-my-zsh
        pkgs.htop
        pkgs.gnugrep # gnu grep is better than bsd grep on MacOS
        pkgs.jq
        pkgs.nixd
      ];

      home.file.".p10k.zsh".source = ./dotfiles/p10k.zsh;

      xdg.configFile."zed/settings.json" = {
        source = ./config/zed_settings.json;
      };

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "24.11";

      programs = {
        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };

        git = {
          enable = true;
          extraConfig = {
            core.editor = "vim";
          };
        };

        vim = {
          enable = true;
          extraConfig = ''
            " Add syntax coloring
            syntax on

            " Configuration file for vim
            set modelines=0		" CVE-2007-2438

            " Enable line numbers
            set number

            " Use Vim defaults instead of 100% vi compatibility
            set nocompatible

            " More powerful backspacing
            set backspace=2

            " Don't write backup file if vim is being called by "crontab -e"
            au BufWrite /private/tmp/crontab.* set nowritebackup

            " Don't write backup file if vim is being called by "chpass"
            au BufWrite /private/etc/pw.* set nowritebackup
          '';
        };

        zsh = {
          enable = true;

          initExtra = ''
            [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

            # Podman Desktop's bin directory
            # Right now, Podman is installed outside of Nix.
            export PATH="/opt/podman/bin:$PATH"
          '';

          oh-my-zsh = {
            enable = true;
            custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
            theme = "powerlevel10k";
            plugins = [
              "git"
            ];
          };

          shellAliases = {
            gl = "git log --graph --pretty=format:'%Cred%h%Creset-%C(yello    )%d%Creset %s %Cgreen(%cr) %C(bold blue) <%an>%Creset'";
          };
        };

        # Let Home Manager install and manage itself.
        home-manager.enable = true;
      };
    }
