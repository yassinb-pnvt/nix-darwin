{
  description = "NixOS and nix-darwin configuration";

  inputs = {
    # apparently it goes like this from fresh to stale:
    # nixos/nixpkgs/master == nixos/nixpkgs
    # nixos/nixpkgs/nixpkgs-unstable
    # nixos/nixpkgs/nixos-2x.xx
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      lix-module,
      nix-darwin,
      nixpkgs,
      home-manager,
      nixpkgs-stable,
      neovim-nightly-overlay,
      ...
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      darwinConfigurations = {
        default = nix-darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            pkgs-stable = import nixpkgs-stable { system = "aarch64-darwin"; };
            inherit neovim-nightly-overlay;
          };

          modules = [
            ./hosts/work/configuration.nix
            lix-module.nixosModules.default

            ./darwin/system.nix
            ./modules/fish-fix.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.verbose = true;
              home-manager.users."yassin.bousaadi" = ./home;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
