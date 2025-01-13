{
  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
    };
  };
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
}
