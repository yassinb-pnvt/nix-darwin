{
  description = "NixOS and nix-darwin configuration";

  inputs = {
    # apparently it goes like this from fresh to stale:
    # nixos/nixpkgs/master == nixoks/nixpkgs
    # nixos/nixpkgs/nixpkgs-unstable
    # nixos/nixpkgs/nixos-2x.xx
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
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

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nixpkgs-stable,
      ...
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          environment = {
            # This doesn't work... idk why tho :(
            # Hold up... maybe???
            variables = {
              GOKU_EDN_CONFIG_FILE = "$HOME/.config/goku/karabiner.edn";
            };
          };

          homebrew = {
            enable = true;
            taps = [ "quarkusio/tap" ];
            brews = [ "quarkus" ];
            casks = [ ];
          };

          # Auto upgrade nix package and the daemon service.
          services = {
            nix-daemon.enable = true;
          };

          nix.settings.experimental-features = "nix-command flakes";
          nixpkgs.config.allowUnfree = true;

          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh.enable = true; # default shell on catalina
          programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 4;

          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # rec used to refer to system in specialArgs
      darwinConfigurations."MB-Q5JMWQ5VFD" = nix-darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = {
          pkgs-stable = import nixpkgs-stable { system = system; };
        };
        # homeModule = home-manager.darwinModules.home-manager {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        #   home-manager.verbose = true;
        #   home-manager.users.maxrn = import ./home;
        #   home-manager.extraSpecialArgs = specialArgs;
        # };
        modules = [
          configuration
          ./darwin/system.nix
          ./work/host-users.nix
          ./modules/fish-fix.nix

          # homeModule
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.maxrn = import ./home;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
