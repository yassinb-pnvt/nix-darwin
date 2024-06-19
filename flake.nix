{
  description = "NixOS and nix-darwin configuration";

  inputs = {
    # apparently it goes like this from fresh to stale:
    # nixos/nixpkgs/master == nixoks/nixpkgs
    # nixos/nixpkgs/nixpkgs-unstable
    # nixos/nixpkgs/nixos-2x.xx
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
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
    {
      darwinConfigurations = (
        import ./work {
          inherit (nixpkgs) lib;
          inherit
            inputs
            nixpkgs
            home-manager
            nix-darwin
            nixpkgs-stable
            ;
        }
      );

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
