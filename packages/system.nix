{ pkgs, pkgs-stable, ... }:
{
  # System-level packages (stable channel)
  system = with pkgs-stable; [
    # Core utilities
    coreutils
    gnused
    
    # System tools
    tree-sitter
  ];
}

