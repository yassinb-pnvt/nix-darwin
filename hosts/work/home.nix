{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sshpass
    # DevOps
    lazydocker
    linuxkit
    docker-buildx
    docker-compose

    ansible
    awscli2
    _1password-cli 

    (python3.withPackages ( ps: [ ps.datadog ps.requests ps.botocore ps.boto3 ps.pyyaml ps.tox ps.pytest ps.pip]))
    # Home setup
    tailscale
    gnupg
    gnused
    ffmpeg
    curl
    bat
    fzf
    jq
    jqp
    fd
    yq
    zoxide
    tree
    wget

    # Shell tools 
    bashInteractive 
    fastfetch
    vim
    neovim
    htop
    ranger
    tmux
    rsync
    ipcalc
    inetutils
    trivy
    ripgrep

    # Versioning
    gh
    git
  ];

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
