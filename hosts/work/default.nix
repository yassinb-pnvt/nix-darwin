{
  nix-darwin,
  nixpkgs-stable,
  nixpkgs,
  home-manager,
  lix-module,
  neovim-nightly-overlay,
  ...
}:
let
  configuration = import ./configuration.nix { pkgs = nixpkgs; };
in
{
  spren = nix-darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = {
      pkgs-stable = import nixpkgs-stable { system = "aarch64-darwin"; };
      inherit neovim-nightly-overlay;
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
