{ pkgs, ... }:
let
  hostname = "Yassins-MacBook-Air";
  username = "yassin.bousaadi";
in
{
  imports = [ ../../modules/configuration.nix ];
  environment = {
    variables = {
    };
  };

  homebrew = {
    enable = true;
    taps = [ "FelixKratz/formulae" ];
    brews = [
      "borders"
      "freerdp"
    ];
    casks = [ 
    "nikitabobko/tap/aerospace"
     "librewolf"
     ];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh.enable = true; 
    fish.enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  system = {
    stateVersion = 4;
    defaults.smb.NetBIOSName = hostname;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking = {
    hostName = hostname;
    computerName = hostname;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
    shell = pkgs.fish;
  };

  nix.settings.trusted-users = [ username ];
}
