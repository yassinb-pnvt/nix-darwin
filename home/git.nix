{ lib, ... }:
{
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Max Große";
    userEmail = "max12.gro@gmail.com";

    ignores = [
      "workspace.code-workspace"
      ".DS_Store"
      ".durl.config"
      "fetch_token.sh"
      ".draci_response.txt"
      ".envrc"
      ".direnv/"
      ".quarkus/"
      ".venv/"
    ];

    includes = [
      {
        # use different email & name for work
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

      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/#merge-conflictstyle-zdiff3
      merge.conflictstyle = "zdiff3";
      diff.algorithm = "histogram";
      branch.sort = "-committerdate";

      diff.tool = "difftastic";
      difftool.prompt = false;
      difftool.difftastic = "difft \"$LOCAL\" \"$REMOTE\"";
      pager.difftool = true;

      diff.colorMoved = "default";
      merge.tool = "nvim";
      credential.helper = "osxkeychain";
      core.excludesFile = "/Users/maxrn/.config/git/ignore";
      rerere.enabled = true;
    };

    aliases = {
      # common aliases
      cm = "commit -m";
      ca = "commit -am";
      cn = "commit --amend --no-edit";
      dc = "diff --cached";

      dft = "difftool";
      dlog = "-c diff.external=difft log -p --ext-diff";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };
}
