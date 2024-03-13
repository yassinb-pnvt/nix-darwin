{...}: {
  # TODO: Maybe this belongs to nix-darwin?
  home.sessionVariables = {
    ZSH_COMPDUMP = "$XDG_CACHE_HOME/zsh/zshcompdump";
  };

  home.shellAliases = {
    zshconfig = "nvim ~/.zshrc";
    ohmyzsh = "nvim ~/.oh-my-zsh";
  };

  programs = {
    fzf = {
      enableZshIntegration = true;
    };

    direnv = {
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      initExtra = ''
        autoload -Uz vcs_info
        precmd() { vcs_info }

        eval "$(fnm env --use-on-cd)"

        export SDKMAN_DIR="/Users/maxrn/.local/share/sdkman"
        source "$SDKMAN_DIR/bin/sdkman-init.sh"

        # switch to main, if it errors switch to master;
        alias gsm=" git switch main 2> /dev/null; [ $? -gt 0 ] && git switch master";


        # Make sure you use single quotes
        zstyle ':vcs_info:git:*' formats '%b'

        setopt PROMPT_SUBST
        # NOTE: the extra quotation marks before the dollar sign is for nix escaping
        # https://www.reddit.com/r/NixOS/comments/jmlohf/escaping_interpolation_in_bash_string/
        # Make sure you use single quotes
        PROMPT='%F{blue}%1~%f (%F{red}''${vcs_info_msg_0_}%f) > '

        alias ls=eza
        bindkey -e
        ssh-add ~/.ssh/github 2> /dev/null

        eval $(opam env)
      '';
    };
  };
}
