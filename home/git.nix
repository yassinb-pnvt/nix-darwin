{ lib, ... }:
{

  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Yassin Bousaadi";
    userEmail = "Yassin.Bousaadi@paynovate.com";

    delta.enable = true; # try new differ https://github.com/dandavison/delta

    ignores = [
      "workspace.code-workspace"
      ".DS_Store"
      ".envrc"
      ".direnv/"
      ".venv/"
      "__pycache__/"
    ];

    includes = [
      {
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
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

      diff.colorMoved = "default";
      merge.tool = "nvim";
      credential.helper = "osxkeychain";
      core.excludesFile = "/Users/yassin.bousaadi/.config/git/ignore";
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

