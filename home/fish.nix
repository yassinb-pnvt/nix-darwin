{ 
  pkgs, ...
 }:
{
  home.sessionVariables = { };

  home.shellAliases = { };

  programs = {
    fzf = {
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zoxide = {
      enable = true;
    };

    fish = {
      enable = true;
      shellInit = ''
        # vi mode
        set fish_vi_key_bindings

        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"

        set DOCKER_CLI_EXPERIMENTAL enabled
        set XDG_CONFIG_HOME /Users/yassin.bousaadi
        set -gx EDITOR (which lvim)
      '';
      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
        { name = "bobthefish"; src = pkgs.fishPlugins.bobthefish.src; }
        { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
        { name = "bass"; src = pkgs.fishPlugins.bass.src; }
        { name = "done"; src = pkgs.fishPlugins.done.src; }
      ];
      shellAbbrs = {
       # Abbreviations 
         "gc"="git clone";
         "gg"="lazygit";
         "dd"="lazydocker";
         "l"="lvim";
         "c"="bat";
         "py"="python3";

      # Docker
         "dc"="docker";
         "dci"="docker image";
         "dcct"="docker container";
         "dcc"="docker compose";
         "dockerprune"="docker system prune -a";

      # Tf abbrevations
         "tf"="terraform";
         "tfa"="terraform apply";
         "tfp"="terraform plan";
         "tff"="terraform fmt";
         "tfi"="terraform init";

      # Ts abbrevations
         "ts"="tailscale";
         "tss"="tailscale status";
         "tsw"="tailscale whois";
      };
      shellAliases = {
      # Aliases
         "l"="lvim";
         "d"="docker";
         "cat"="bat -p";
         "c"="bat";
      };
    };
  };
}

