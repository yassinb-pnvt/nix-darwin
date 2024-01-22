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

        setenv SSH_ENV $HOME/.ssh/environment

        function start_agent
            echo "Initializing new SSH agent ..."
            ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
            echo "succeeded"
            chmod 600 $SSH_ENV
            . $SSH_ENV > /dev/null
            ssh-add
        end

        function test_identities
            ssh-add -l | grep "The agent has no identities" > /dev/null
            if [ $status -eq 0 ]
                ssh-add
                if [ $status -eq 2 ]
                    start_agent
                end
            end
        end

        if [ -n "$SSH_AGENT_PID" ]
            ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
            if [ $status -eq 0 ]
                test_identities
            end
        else
            if [ -f $SSH_ENV ]
                . $SSH_ENV > /dev/null
            end
            ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
            if [ $status -eq 0 ]
                test_identities
            else
                start_agent
            end
        end

        # ssh-add ~/.ssh/github 2> /dev/null
      '';
    };
  };
}
