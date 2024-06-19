{
  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
}
