{
  config,
  pkgs,
  pkgs-stable,
  ...
}:
let
  # needs to be absolute path. Important!
  homeManager = /Users/maxrn/.config/nix-darwin/home;
  link = config.lib.file.mkOutOfStoreSymlink;
  l = x: link homeManager + "/${x}";
in
{
  imports = [
    ./git.nix
    ./fish.nix
    ./darwin.nix
    ./tmux.nix
    ../work/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "maxrn";
  home.homeDirectory = "/Users/maxrn";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Because for some reason they are not included by default.
    # Would like to have the BSD ones for MacOS but these'll do.
    pkgs-stable.man-pages

    wezterm

    vscode
    discord

    texliveFull

    anki-bin

    # programming langs
    go_1_22
    rustup
    pkgs-stable.poetry
    php83
    php83Packages.composer
    opam
    jdk21
    nixd

    bat
    btop
    curl
    wget
    fd
    ffmpeg
    fnm
    kubectl
    kubernetes-helm
    neofetch
    neovim
    pandoc
    ripgrep
    tree
    tree-sitter
    nixfmt-rfc-style
    jq
    gnused
    difftastic
    hyperfine
    cloc
    yt-dlp
    zld # faster linker
    goku

    gh

    sqlite
    sqlite-utils
    shellcheck

    devenv
    minikube
    gimp
    sioyek
    flyctl
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/wezterm".source = l "dotfiles/wezterm";
    ".config/goku".source = l "dotfiles/goku";
    ".config/nvim".source = l "dotfiles/nvim";
    ".config/bat".source = l "dotfiles/bat";
  };

  # TODO: Maybe this belongs to nix-darwin?
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    SUMO_HOME = "/opt/homebrew/opt/sumo/share/sumo";
  };

  home.shellAliases = {
    hm = "home-manager";
    vim = "nvim";
    gdp = "git diff -p";
    glp = "git log -p";
    gsp = "git diff --staged -p";
    gbl = "git branch --list";
    gnew = "git switch -c";
    gs = "git status";
    dbu = "docker compose up -d --build";
    fzvim = "fzf | xargs nvim";
    ll = "ls -lah";
    k = "kubectl";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$XDG_CONFIG_HOME/nix-darwin/home/dotfiles/scripts"
    "$HOME/.local/bin"
    "$HOME/Library/Python/3.10/bin"
    "./node_modules/.bin"
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

    eza = {
      enable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  fonts.fontconfig.enable = true;
}
