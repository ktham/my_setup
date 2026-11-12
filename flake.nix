{
  description = "NixOS configuration used by ktham";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinned to a release tag, so `nix flake update` does not upgrade tailscale.
    # To upgrade, change the tag below and run `nix flake update tailscale`.
    tailscale = {
      url = "github:tailscale/tailscale/v1.104.6";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nix-darwin, tailscale }:
  let
    username = "kevintham";
    homeDirectory = "/Users/${username}";
    system = "aarch64-darwin";

    tailscalePkg = tailscale.packages.${system}.tailscale;

    darwinConfiguration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
        tailscalePkg
      ];

      # tailscaled is started by launchd at boot. First-time setup on a
      # fresh machine requires a one-time `tailscale up` to authenticate;
      # node state persists in /Library/Tailscale/ and re-auths on reboot.
      #
      # Logs:    /var/log/tailscaled.log
      # Restart: sudo launchctl kickstart -k system/com.tailscale.tailscaled
      launchd.daemons.tailscaled = {
        command = "${tailscalePkg}/bin/tailscaled";
        serviceConfig = {
          Label = "com.tailscale.tailscaled";
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/var/log/tailscaled.log";
          StandardErrorPath = "/var/log/tailscaled.log";
        };
      };

      nix.enable = false;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      system.primaryUser = username;

      system.defaults = {
        finder = {
          # system.default.finder.AppleShowAllFiles executes this:
          # `defaults write com.apple.finder AppleShowAllFiles YES`
          #
          # Note: When this is set for the first time, you'll need to run
          # `killall Finder` to force Finder to reload to show hidden files.
          AppleShowAllFiles = true;
        };

        # TODO: Doesn't work
        # Enforce password immediately screen saver begins or display is off
        # Equivalent to setting in MacOS (Sequoia) System Settings > Lock Screen
        # screensaver = {
        #   askForPassword = true;
        #   askForPasswordDelay = 0;
        # };
      };

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Nix needs to know what our home directory is for home-manager to work
      # See: https://github.com/nix-darwin/nix-darwin/issues/423
      users.users.${username}.home = homeDirectory;
    };
  in
  {
    darwinConfigurations.ktham-mac = nix-darwin.lib.darwinSystem {
      modules = [
        darwinConfiguration

        # `home-manager` module
        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home-manager.nix {
            inherit username homeDirectory;
          };
          # When an existing file is in the way, back it up with a .backup ext
          home-manager.backupFileExtension = "backup";

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
