{...}: {
  # TODO: Maybe this belongs to nix-darwin?
  home.sessionVariables = {
    ZSH_COMPDUMP = "$XDG_CACHE_HOME/zsh/zshcompdump";
  };

  home.shellAliases = {
    zshconfig = "nvim ~/.zshrc";
    ohmyzsh = "nvim ~/.oh-my-zsh";
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "docker" "docker-compose" "kubectl" "helm"];
      theme = "robbyrussell";
    };
    initExtra = ''
      bindkey '^ ' autosuggest-accept

      eval "$(fnm env --use-on-cd)"

      function inspiration() {
          fortune | cowsay -f $(node -e "var c='$(cowsay -l | sed "1d" | paste -s -d " " -)'.split(' ');console.log(c[Math.floor(Math.random()*c.length)])") | lolcat --seed 0 --spread 1.0
      }

      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';
  };
}
