{
  nix-darwin,
  nixpkgs-stable,
  nixpkgs,
  home-manager,
  lix-module,
  ...
}:
let
  configuration = import ./configuration.nix { pkgs = nixpkgs; };
in
{
  "MB-Q5JMWQ5VFD" = nix-darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = {
      pkgs-stable = import nixpkgs-stable { system = "aarch64-darwin"; };
    };

    modules = [
      configuration
      lix-module.nixosModules.default

      ../../darwin/system.nix
      ../../modules/fish-fix.nix

      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.verbose = true;
        home-manager.users.maxrn = import ../../home;
        home-manager.extraSpecialArgs = specialArgs;
      }
    ];
  };
}
