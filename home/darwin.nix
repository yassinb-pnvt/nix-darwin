{ config, pkgs, ... }:
let
#  homemanagerhome = "/users/yassin.bousaadi/.config/home-manager";
#  link = config.lib.file.mkoutofstoresymlink;
#  linkhome = x: link "${homemanagerhome}" + "/${x}";
in
{

  home.packages = with pkgs; [ gnupatch ];
}
