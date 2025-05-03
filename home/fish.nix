{ 
  pkgs, ...
 }:
{
  home.sessionVariables = { };

  home.shellAliases = { };

  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    ghostty = {
      enableFishIntegration = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        # vi mode
        set fish_vi_key_bindings
      '';
      shellInit = ''
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"

        # Tooling 
        fzf --fish | source
        op completion fish | source
      '';
      functions = {
        # TODO : Add more use cases with args like ssh'ing into other users if necessary or change the user.
        # TODO : Make a better fzf window with tmux, maybe with ts status, test ping, add other functionalities with other fzf binds
        ssh-ts=''
          set fzfcmd "enter:become(ssh {}),alt-enter:become(ssh root@{} ),ctrl-e:change-preview(echo {\$json_ip} | jq '.Peer[]  | select( .HostName == \"{}\") ' | bat --style=numbers --color=always --language=json),ctrl-r:change-preview-label(Testing connection: {})+change-preview( ping {})"
          set -Ux json_ip (tailscale status --json) && echo $json_ip | jq '. | .Peer[] | .HostName' --raw-output | fzf --multi --preview "echo {\$json_ip} | jq '.Peer[]  | select( .HostName == \"{}\" ) | { Name: .HostName, OS:.OS, DNSName:.DNSName, IPs: .TailscaleIPs, Online: .Online }' | bat --style=numbers --color=always --language=json" --bind $fzfcmd --tmux 60%; set -e json_ip
        '' ;
        # Small function to update all the repos from the current dir (projects or project/paynovate)
        update-repos=''
          fd . --maxdepth 1 -x sh -c " echo 'Updating repo {}' && cd {} && git pull"
        '';
      };
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

