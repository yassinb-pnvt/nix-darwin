{nix-darwin, ...}:
{nix-darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = {
          pkgs-stable = import nixpkgs-stable { system = "aarch64-darwin"; };
          work-module = ./work/default.nix;
        };

        modules = [
          configuration

          ./darwin/system.nix
          ./work/host-users.nix
          ./modules/fish-fix.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.maxrn = import ./home;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      }
}
