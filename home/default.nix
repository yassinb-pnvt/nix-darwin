{
  config,
  pkgs,
  pkgs-stable,
  neovim-nightly-overlay,
  ...
}:
let
  # needs to be absolute path. Important!
  homeManager = /Users/yassin.bousaadi/.config/nix-darwin/home;
  link = config.lib.file.mkOutOfStoreSymlink;
  l = x: link homeManager + "/${x}";
in
{
  imports = [
    ./git.nix
    ./fish.nix
    ./darwin.nix
    ./tmux.nix
    ../hosts/work/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yassin.bousaadi";
  home.homeDirectory = "/Users/yassin.bousaadi";
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/lvim".source = l "dotfiles/lvim";
    ".config/aerospace".source = l "dotfiles/aerospace";
    ".config/ghostty".source = l "dotfiles/ghostty";
  };
  
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages =
    let
      stable = with pkgs-stable; [ ];
      unstable = with pkgs; [
        # DevOps
        podman
        ansible
        lazydocker
        colima
        libvirt
        linuxkit
        docker-buildx
        docker-compose

        # non free pckgs
        packer
        terraform
        docker

        # CLIs
        curl
        awscli2
        wireshark
        alacritty
        direnv

        # fish
        fish
        fzf
        jq
        jqp
        fd
        yq
        zoxide
        tree
        wget
        bat 
        btop
        curl
        wget
        ripgrep
        tree
        bashInteractive 
        delta
        fastfetch
        vim
        lunarvim
        neovim
        ranger
        tailscale
        bitwarden-cli
        tmux
        pandoc
        rsync
        commitlint
        ipcalc
        htop
        inetutils
        trivy
        ripgrep
        gnupg
        lnav

        # Languages
        just
        rustc
        rustup
        just
        go
        ktlint

        # Versioning
        git
        lazygit
        gh

        # other tools
        tree-sitter
        coreutils
        gnused
      ];
    in
    stable ++ unstable ++ [ neovim-nightly-overlay.packages.${pkgs.system}.default ];

  

  # TODO: Maybe this belongs to nix-darwin?
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "/opt/homebrew/bin"
  ];

  programs = {
    fzf = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home-manager.enable = true;

    zoxide = {
      enable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # fonts.fontconfig.enable = true;
}
