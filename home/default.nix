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
    ./darwin.nix
    ./fish.nix
    # ./tmux.nix
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
    # ".config/fish".source = l "dotfiles/fish";
    ".config/gh".source = l "dotfiles/gh";
    ".config/bat".source = l "dotfiles/bat";
    ".config/ghostty".source = l "dotfiles/ghostty";
  };
    
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages =
    let
      stable = with pkgs-stable; [ 
        gum
        hurl
        sesh 

        oh-my-fish
        delta
        direnv
        grc

        # SHELL TOOLS 
        btop
        pandoc

        # Versioning
        lazygit
        lnav

        # DevOps
        colima
        ansible
        qemu

        # CLIs
        awscli2
        lunarvim

        # Languages
        nodejs
        just
        rustc
        rustup
        just
        go
        ktlint
        python3Full
        python312Packages.datadog

        # other tools
        tree-sitter
        coreutils
      ];
      unstable = with pkgs; [

        trivy
        # non free pckgs <- Not actually sorted yet, idk which is free or not lol
        vault
        docker
        # bitwarden-cli
        _1password-cli

      ];
    in
    stable ++ unstable ++ [ neovim-nightly-overlay.packages.${pkgs.system}.default ];

    

  # TODO: Maybe this belongs to nix-darwin?
  home.sessionVariables = {
    EDITOR = "lvim";
    TERM = "xterm-256color";
    SHELL = "/etc/profiles/per-user/yassin.bousaadi/bin/fish";
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
    home-manager.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  fonts.fontconfig.enable = true;
}
