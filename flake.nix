{
  description = "NixOS and nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    nix-darwin,
    home-manager,
    lix-module,
    neovim-nightly-overlay,
    ...
  }:
  let
    system = "aarch64-darwin";

    nodeOverlay = final: prev: {
      nodejs = prev.nodejs_22;
      nodejs-slim = prev.nodejs-slim_22;

      nodejs_20 = prev.nodejs_22;
      nodejs-slim_20 = prev.nodejs-slim_22;
    };


    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
      overlays = [ nodeOverlay ];
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;
    };

    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

  in {
    darwinConfigurations.default = nix-darwin.lib.darwinSystem {
      inherit system;

      specialArgs = {
        inherit pkgs pkgs-stable neovim-nightly-overlay;
      };

      modules = [
        ./hosts/work/configuration.nix
        lix-module.nixosModules.default
        ./darwin/system.nix
        ./modules/fish-fix.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users."yassin.bousaadi" = ./home;
          home-manager.extraSpecialArgs = {
            inherit pkgs pkgs-stable neovim-nightly-overlay;
          };
        }

        # Optional: reapply allowUnfree at system level just in case
        {
          nixpkgs.config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        }
      ];
    };

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
  };
}

