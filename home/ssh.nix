{ ... }:
{
  # SSH configuration to prevent sending TERM to remote hosts
  programs.ssh = {
    enable = true;
    # Disable default config to avoid deprecation warning
    enableDefaultConfig = false;
    
    # Preserve existing SSH config by including external configs
    includes = [
      "/Users/yassin.bousaadi/.config/colima/ssh_config"
      "/Users/yassin.bousaadi/.colima/ssh_config"
    ];
    
    # Preserve all your existing hosts
    matchBlocks = {
      "*" = {
        # Default settings for all hosts
        user = "root";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
        # Don't send TERM - handled via extraConfig SendEnv below
      };
      
      "94.237.83.65" = {
        user = "yassin";
        identityFile = "~/.ssh/id_ed25519";
        forwardAgent = true;
        extraOptions = {
          ControlPersist = "yes";
        };
      };
      
      "ci-office1" = {
        hostname = "192.168.28.207";
        user = "gh-runner";
        identityFile = "~/.ssh/gh-docker";
        forwardAgent = true;
        extraOptions = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/control-%C";
          ControlPersist = "yes";
        };
      };
      
      "perso.github.com" = {
        hostname = "github.com";
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_perso";
        identitiesOnly = true;
        user = "Yassin.Bousaadi";
        extraOptions = {
          UseKeychain = "yes";
        };
      };
      
      "github.com" = {
        hostname = "github.com";
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_rsa";
        identitiesOnly = true;
        user = "Yassin.Bousaadi";
        extraOptions = {
          UseKeychain = "yes";
        };
      };
      
      "gitlab.com" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_rsa";
        extraOptions = {
          UseKeychain = "yes";
        };
      };
      
      "webbis" = {
        user = "yassin";
        port = 22;
        hostname = "webbis.loyaltek.com";
        identityFile = "~/.ssh/webbis_key";
        extraOptions = {
          HostKeyAlgorithms = "+ssh-rsa";
          PubkeyAcceptedAlgorithms = "+ssh-rsa";
        };
      };
      
      "baxter" = {
        user = "yassin";
        port = 22;
        hostname = "baxter.loyaltek.com";
        extraOptions = {
          HostKeyAlgorithms = "+ssh-rsa";
          PubkeyAcceptedAlgorithms = "+ssh-rsa";
        };
      };
      
      "ctaphost-dev-ec1a" = {
        extraOptions = {
          StrictHostKeyChecking = "no";
          UserKnownHostsFile = "/dev/null";
        };
      };
    };
    
    extraConfig = ''
      # Don't send TERM to remote hosts by default
      # This prevents advanced TERM values (like tmux-256color) from being sent to SSH sessions
      # Remote hosts will use their default TERM or xterm
      SendEnv -TERM
    '';
  };
}
