{
  config,
  lib,
  pkgs,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    # TODO replace with your own name & email
    userName = "Max Große";
    userEmail = "max12.gro@gmail.com";

    ignores = [
      "workspace.code-workspace"
      ".DS_Store"
      ".durl.config"
      "fetch_token.sh"
      ".draci_response.txt."
      ".envrc"
      ".direnv/"
    ];

    includes = [
      {
        # use diffrent email & name for work
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
      }
      {
        condition = "gitdir:~/uni/";
        path = "~/uni/.gitconfig";
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      amend = "commit --amend -m";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };
}
