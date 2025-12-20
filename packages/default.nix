{ pkgs, pkgs-stable, ... }:
let
  system = import ./system.nix { inherit pkgs pkgs-stable; };
  cli-tools = import ./cli-tools.nix { inherit pkgs pkgs-stable; };
  dev-tools = import ./dev-tools.nix { inherit pkgs pkgs-stable; };
  languages = import ./languages.nix { inherit pkgs pkgs-stable; };
  docker = import ./docker.nix { inherit pkgs-stable; };
  shell = import ./shell.nix { inherit pkgs-stable; };
in
{
  # Combine all package sets
  all = system.system
    ++ cli-tools.cli-tools
    ++ dev-tools.dev-tools
    ++ languages.languages
    ++ docker.docker
    ++ shell.shell;
}

