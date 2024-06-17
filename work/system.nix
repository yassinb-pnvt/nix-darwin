{
  nix-darwin,
  nixpkgs-stable,
  nixpkgs,
  home-manager,
  self,
}:
let
  configuration = import ./configuration.nix {
    pkgs = nixpkgs;
    self = self;
  };
in
nix-darwin.lib.darwinSystem rec {
  system = "aarch64-darwin";
  specialArgs = {
    pkgs-stable = import nixpkgs-stable { system = "aarch64-darwin"; };
    work-module = ./work/default.nix;
  };

  modules = [
    configuration

    ../darwin/system.nix
    ./host-users.nix
    ../modules/fish-fix.nix

    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      home-manager.users.maxrn = import ../home;
      home-manager.extraSpecialArgs = specialArgs;
    }
  ];
}
