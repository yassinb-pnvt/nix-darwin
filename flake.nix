{
  description = "My nix-darwin config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixpkgs-stable
    , nixpkgs-master, ... }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment = {
          systemPackages = [
            # Better karabiner config
            pkgs.goku
          ];

          # This doesn't work... idk why tho :(
          # Hold up... maybe???
          variables = {
            GOKU_EDN_CONFIG_FILE = "$HOME/.config/goku/karabiner.edn";
          };
        };

        homebrew = {
          enable = true;
          taps = [ "quarkusio/tap" ];
          brews = [ "cowsay" "quarkus" ];
          casks = [ ];
        };

        # Auto upgrade nix package and the daemon service.
        services = {
          nix-daemon.enable = true;
          # karabiner-elements.enable = true;
        };

        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs.config.allowUnfree = true;

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        programs.fish.enable = true; # default shell on catalina

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#MB-Q5JMWQ5VFD
      # rec used to refer to system in specialArgs
      darwinConfigurations."MB-Q5JMWQ5VFD" = nix-darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = {
          pkgs-stable = import nixpkgs-stable { system = system; };
          neovim-10 = import nixpkgs-stable { system = system; };
        };
        modules = [
          configuration
          ./modules/system.nix
          ./modules/host-users.nix
          ./modules/fish-fix.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users."maxrn" = import ./home;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."MB-Q5JMWQ5VFD".pkgs;
    };
}
