{ config, pkgs, ... }:
let
#  homemanagerhome = "/users/yassin.bousaadi/.config/home-manager";
#  link = config.lib.file.mkoutofstoresymlink;
#  linkhome = x: link "${homemanagerhome}" + "/${x}";
in
{
  # home.shellaliases = {
  #   tailscale = "/applications/tailscale.app/contents/macos/tailscale";
  # };

  # home.file = {
  #   ".config/goku/karabiner.edn".source = linkhome "dotfiles/goku/karabiner.edn";
  # };

  home.packages = with pkgs; [ gnupatch ];
}
