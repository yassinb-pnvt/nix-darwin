{ lib, ... }:
{
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
    '';

  programs = {
    delta = { 
      enable = true;
      enableGitIntegration = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
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
        path = "~/personal/.gitconfig";
      }
      ];

      settings = {
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
        user = {
          name = "Yassin Bousaadi";
          email = "yassin.bousaadi@paynovate.com";
        }; 
        alias = {
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
    };
  };
}
