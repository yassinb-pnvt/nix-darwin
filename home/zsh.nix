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
        zmodload zsh/zprof

        bindkey '^ ' autosuggest-accept

        eval "$(fnm env --use-on-cd)"

        function inspiration() {
            fortune | cowsay -f $(node -e "var c='$(cowsay -l | sed "1d" | paste -s -d " " -)'.split(' ');console.log(c[Math.floor(Math.random()*c.length)])") | lolcat --seed 0 --spread 1.0
        }

        PROMPT="max@mbp: ";

        ssh-add ~/.ssh/github 2> /dev/null
      '';
    };
  };
}
