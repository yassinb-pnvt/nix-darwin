
{
  home.sessionVariables = { };

  home.shellAliases = { };

  programs = {
    fzf = {
      enableFishIntegration = true;
    };

    fish = {
      enable = true;
      shellInit = ''
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
      '';
    };
  };
}

