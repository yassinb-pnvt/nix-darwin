{ pkgs-stable, ... }:
{
  # Docker and containerization tools
  docker = with pkgs-stable; [
    docker
    docker-credential-helper
  ];
}

