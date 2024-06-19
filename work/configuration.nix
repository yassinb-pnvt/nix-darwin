{ pkgs, ... }:
{
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

  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
