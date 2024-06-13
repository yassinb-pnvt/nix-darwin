{ config, ... }:
let
  homeManagerHome = "/Users/maxrn/.config/home-manager";
  link = config.lib.file.mkOutOfStoreSymlink;
  linkHome = x: link "${homeManagerHome}" + "/${x}";
in
{
  home.shellAliases = {
    skim = "open -a /Applications/Skim.app";
  };

  home.file = {
    ".config/goku/karabiner.edn".source = linkHome "dotfiles/goku/karabiner.edn";
  };
}
