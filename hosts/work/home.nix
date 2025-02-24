{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnupg
    yq

      # Home setup
        pet
        ffmpeg
        curl
        awscli2
        wireshark
        alacritty
        direnv
        bat
        fzf
        jq
        jqp
        fd
        yq
        zoxide
        tree
        wget

      # Fish
        fish

      # - TODO [ ]: Add the plugins and refer them in the fish-fix
        # fishPlugins.fzf
        # fishPlugins.fzf-fish
        # fishPlugins.bobthefish
        # fishPlugins.bass
        # fishPlugins.done
      
      # Shell tools 
        fastfetch

        vim
        lunarvim
        neovim

        delta
        htop
        ranger
        bitwarden-cli
        tmux
        pandoc
        rsync
        ipcalc
        inetutils
        trivy
        gnupg
        ripgrep
        lnav

      # DevOps tools
        tailscale
        ansible
        lazydocker
        colima
        libvirt
        linuxkit
        docker-buildx
        docker-compose
        podman
        qemu

      # Languages
        uv
        just
        rustc
        rustup
        just
        php
        go
        ktlint
        ripgrep

      # Versioning
        lazygit
        commitlint
        gh
        git

      # universal-ctags
      # non free pckgs
        packer
        terraform
        docker
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
