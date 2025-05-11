{
  description = "NixOS configuration used by ktham";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-darwin }:
  let
    username = "kevintham";
    homeDirectory = "/Users/${username}";

    darwinConfiguration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
      ];

      nix.enable = false;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

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
          home-manager.users.${username} = import ./home.nix {
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
