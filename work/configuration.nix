{ pkgs, ... }:
let
  config = import ../shared/configuration.nix;
  hostname = "MB-Q5JMWQ5VFD";
  username = "maxrn";
in
pkgs.lib.attrsets.recursiveUpdate config {
  environment = {
    # This doesn't work... idk why tho :(
    # Hold up... maybe???
    variables = {
      GOKU_EDN_CONFIG_FILE = "$HOME/.config/goku/karabiner.edn";
    };
  };

  homebrew = {
    enable = true;
    taps = [ "quarkusio/tap" ];
    brews = [ "quarkus" ];
    casks = [ ];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
    shell = pkgs.fish;
  };

  nix.settings.trusted-users = [ username ];
}
