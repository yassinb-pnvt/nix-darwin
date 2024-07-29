{ pkgs, ... }:
let
  hostname = "MB-Q5JMWQ5VFD";
  username = "maxrn";
in
{
  imports = [ ../../shared/configuration.nix ];
  environment = {
    # This doesn't work... idk why tho :(
    # Hold up... maybe???
    variables = {
      GOKU_EDN_CONFIG_FILE = "$HOME/.config/goku/karabiner.edn";
    };
  };

  homebrew = {
    enable = true;
    taps = [ ];
    brews = [
      "pcre"
      "gmp"
      "openssl"
      "libev"
      "pkg-config"
    ];
    casks = [ ];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh.enable = true; # default shell on catalina
    fish.enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
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
