{ lib, ... }:
{
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Yassin Bousaadi";
    userEmail = "yassin.bousaadi@paynovate.com";

    delta.enable = true;

    ignores = [
      "workspace.code-workspace"
      ".DS_Store"
      ".envrc"
      ".direnv/"
      ".venv/"
      "__pycache__/"
      ".cache/"
      "*.swp"
      "shell.nix"
    ];

    includes = [
      {
        condition = "gitdir:~/personal/";
        path = ".config/git/personal-config";
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
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
      cm = "commit -m";
      ca = "commit -am";
      cn = "commit --amend --no-edit";
      dc = "diff --cached";
      dft = "difftool";
      dlog = "-c diff.external=difft log -p --ext-diff";
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };

  home.file.".config/git/personal-config" = {
    text = ''
      [user]
        name = Yassin Bousaâdi
        email = yassin.bousaadi@gmail.com
    '';
  };
}
