{pkgs, ...}: {
  # TODO: Maybe this belongs to nix-darwin?
  home.sessionVariables = {
  };

  home.shellAliases = {
  };

  programs = {
    fzf = {
      enableFishIntegration = true;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
      ];
      shellInit = ''
        set -g SDKMAN_DIR /Users/maxrn/.local/share/sdkman
        set -g SDKMAN_CANDIDATES_DIR /Users/maxrn/.local/share/sdkman/candidates

        eval "$(fnm env --use-on-cd)"

        function sdk
            bass source ~/.local/share/sdkman/bin/sdkman-init.sh ';' sdk $argv
        end

        set fish_greeting

        ssh-add ~/.ssh/github 2> /dev/null
      '';
    };
  };
}
