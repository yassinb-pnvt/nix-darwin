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
    ../hosts/work/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "maxrn";
  home.homeDirectory = "/Users/maxrn";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.wezterm

    pkgs.vscode

    pkgs.texliveFull
    pkgs.sioyek

    pkgs.anki-bin

    # programming langs
    pkgs.go_1_22
    pkgs.rustup
    pkgs.poetry
    pkgs.opam
    pkgs.jdk21
    pkgs.nixd

    pkgs.bat
    pkgs.btop
    pkgs.curl
    pkgs.wget
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fnm
    # kubectl --> using rancher on work machine
    # kubernetes-helm --> using rancher on work machine
    pkgs.neofetch
    pkgs.neovim
    pkgs.pandoc
    pkgs.ripgrep
    pkgs.tree
    pkgs.tree-sitter
    pkgs.nixfmt-rfc-style
    pkgs.jq
    pkgs.gnused
    pkgs.difftastic
    pkgs.hyperfine
    pkgs.tokei # better SLOC estimater than cloc
    pkgs.yt-dlp
    pkgs.zld # faster linker
    pkgs.goku

    pkgs.gh

    pkgs.sqlite
    pkgs.sqlite-utils
    pkgs.shellcheck

    pkgs.devenv
    pkgs.minikube
    pkgs.flyctl
    pkgs.lnav
    pkgs.atuin

    pkgs.dive # because everytime I need it I have to re-download it again
    # and nix NEVER caches the stupid flake WHAT
    # pkgs-stable.valgrind
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/wezterm".source = l "dotfiles/wezterm";
    ".config/goku".source = l "dotfiles/goku";
    ".config/nvim".source = l "dotfiles/nvim";
    ".config/bat".source = l "dotfiles/bat";
    ".config/aerospace".source = l "dotfiles/aerospace";
  };

  # TODO: Maybe this belongs to nix-darwin?
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    SUMO_HOME = "/opt/homebrew/opt/sumo/share/sumo";
    # Ugly hack to get man working correctly. Yes, I know there is doubling in there. Yes, I know I have hardcoded my user name.
    MANPATH = "/Users/maxrn/.local/state/fnm_multishells/68242_1731052803936/share/man:/etc/profiles/per-user/maxrn/share/man:/run/current-system/sw/share/man:/nix/var/nix/profiles/default/share/man:/usr/local/share/man:/System/Cryptexes/App/usr/share/man:/usr/share/man:/opt/X11/share/man:/Library/TeX/texbin/man:/Users/maxrn/.local/state/fnm_multishells/44311_1730708868618/share/man:/Users/maxrn/Library/Python/3.10/share/man:/opt/homebrew/share/man:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man:/Applications/Xcode.app/Contents/Developer/usr/share/man:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:/Users/maxrn/.local/state/fnm_multishells/68242_1731052803936/share/man:/etc/profiles/per-user/maxrn/share/man:/run/current-system/sw/share/man:/nix/var/nix/profiles/default/share/man:/usr/local/share/man:/System/Cryptexes/App/usr/share/man:/usr/share/man:/opt/X11/share/man:/Library/TeX/texbin/man:/Users/maxrn/.local/state/fnm_multishells/44311_1730708868618/share/man:/Users/maxrn/Library/Python/3.10/share/man:/opt/homebrew/share/man:echo:/Users/maxrn/.local/state/fnm_multishells/68242_1731052803936/share/man:/etc/profiles/per-user/maxrn/share/man:/run/current-system/sw/share/man:/nix/var/nix/profiles/default/share/man:/usr/local/share/man:/System/Cryptexes/App/usr/share/man:/usr/share/man:/opt/X11/share/man:/Library/TeX/texbin/man:/Users/maxrn/.local/state/fnm_multishells/44311_1730708868618/share/man:/Users/maxrn/Library/Python/3.10/share/man:/opt/homebrew/share/man:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man:/Applications/Xcode.app/Contents/Developer/usr/share/man:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:/Users/maxrn/.local/state/fnm_multishells/68242_1731052803936/share/man:/etc/profiles/per-user/maxrn/share/man:/run/current-system/sw/share/man:/nix/var/nix/profiles/default/share/man:/usr/local/share/man:/System/Cryptexes/App/usr/share/man:/usr/share/man:/opt/X11/share/man:/Library/TeX/texbin/man:/Users/maxrn/.local/state/fnm_multishells/44311_1730708868618/share/man:/Users/maxrn/Library/Python/3.10/share/man:/opt/homebrew/share/man";
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
    "$HOME/.rd/bin"
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
