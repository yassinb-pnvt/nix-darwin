{...}: {
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
      shellInit = ''
        # bindkey '^ ' autosuggest-accept
        #
        # eval "$(fnm env --use-on-cd)"
        #
        # function inspiration() {
        #     fortune | cowsay -f $(node -e "var c='$(cowsay -l | sed "1d" | paste -s -d " " -)'.split(' ');console.log(c[Math.floor(Math.random()*c.length)])") | lolcat --seed 0 --spread 1.0
        # }
        #
        # ssh-add ~/.ssh/github 2> /dev/null
      '';
    };
  };
}
