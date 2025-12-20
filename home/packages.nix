{ pkgs, pkgs-stable, ... }:
let
  stable = with pkgs-stable; [
    # CLI tools
    ansible
    gum
    gnused
    hurl
    sesh
    choose-gui

    # Docker
    docker
    
    # Shell enhancements
    oh-my-fish
    grc

    # Shell tools
    btop
    pandoc
    dive
    lazydocker
    lnav

    # Versioning
    lazygit

    # DevOps
    opentofu
    colima
    qemu

    # CLIs
    awscli2
    lunarvim

    # Languages
    nodejs
    just
    rustc
    rustup
    go
    ktlint

    # Other tools
    tree-sitter
    coreutils
    gitleaks

    # Python with packages
    (python3.withPackages (ps: [
      ps.ansible
      ps.datadog
      ps.requests
      ps.botocore
      ps.boto3
      ps.pyyaml
      ps.tox
      ps.pytest
      ps.pip
    ]))
  ];
  
  unstable = with pkgs; [
    # DevOps tools
    trivy
    inframap
    terraform
    terraformer
    packer
    vault
    _1password-cli

    # Shell tools
    sshpass
    docker-buildx
    docker-compose
    tailscale
    gnupg
    ffmpeg
    curl
    bat
    jq
    jqp
    fd
    yq-go
    tree
    wget
    bashInteractive
    fastfetch
    vim
    neovim
    htop
    ranger
    rsync
    ipcalc
    inetutils
    ripgrep

    # Versioning
    gh

    # Languages
    deno
  ];
in
{
  home.packages = stable ++ unstable;
}
