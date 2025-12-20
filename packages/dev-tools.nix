{ pkgs, pkgs-stable, ... }:
{
  # Development tools
  dev-tools = with pkgs; [
    # Version control
    gh
    lazygit
    
    # Editors
    vim
    neovim
    
    # DevOps & Infrastructure
    trivy
    inframap
    terraform
    terraformer
    packer
    vault
    docker-buildx
    docker-compose
    
    # Security
    gitleaks
  ] ++ (with pkgs-stable; [
    # Stable dev tools
    ansible
    opentofu
    colima
    qemu
    awscli2
    lunarvim
  ]);
}

