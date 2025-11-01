{ pkgs, pkgs-stable, neovim-nightly-overlay, ... }:
{
  home.packages = 
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
        # delta - configured via programs
        # direnv - configured via programs
        grc

        # Shell tools
        btop
        pandoc
        dive
        lazydocker

        # Versioning
        lazygit
        lnav

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
        (python3.withPackages ( ps: [ ps.datadog ps.requests ps.botocore ps.boto3 ps.pyyaml ps.tox ps.pytest ps.pip]))
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
        # fzf - configured via programs
        jq
        jqp
        fd
        yq
        # zoxide - configured via programs
        tree
        wget
        bashInteractive
        fastfetch
        vim
        neovim
        htop
        ranger
        # tmux - configured via programs
        rsync
        ipcalc
        inetutils
        ripgrep

        # Versioning
        gh
        # git - configured via programs

        # Neovim nightly - temporarily disabled due to build issues
        # neovim-nightly-overlay.packages.${pkgs.system}.default
      ];
    in
    stable ++ unstable;

  home.sessionVariables = {
    # ************************** for using rancher **************************************
    # sudo ln -s ~/.rd/docker.sock /var/run/docker.sock

    # ************************ For using colima ***************************************************
    # LINK colima docker sock to /var/run/docker.sock
    # For testcontainers
    # https://java.testcontainers.org/supported_docker_environment/#colima

    # colima start --network-address
    # export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
    # export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
    # export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
    # I just linked .colima/default/docker.sock to /var/run/docker.sock -> easiest solution ever
    # TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "/var/run/docker.sock";
    # TESTCONTAINERS_HOST_OVERRIDE = "$(colima ls -j | jq -r '.address')";
    # DOCKER_HOST = "unix://$HOME/.colima/default/docker.sock";

    # Old version in case testcontainers act up again
    # TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "/var/run/docker.sock";
    # TESTCONTAINERS_RYUK_DISABLED = "true";
    # DOCKER_HOST = "unix:///Users/maxrn/.colima/docker.sock";
    # remember to use .config here too
  };
}
