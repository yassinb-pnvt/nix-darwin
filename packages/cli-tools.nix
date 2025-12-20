{ pkgs, pkgs-stable, ... }:
{
  # CLI tools and utilities
  cli-tools = with pkgs; [
    # File operations
    bat
    fd
    ripgrep
    tree
    rsync
    
    # Text processing
    jq
    jqp
    yq-go
    gnupg
    
    # Network tools
    curl
    xh  # Modern curl alternative with better defaults and colored output
    wget
    tailscale
    sshpass
    ipcalc
    inetutils
    
    # System monitoring
    htop
    btop
    fastfetch
    ranger
    
    # Shell enhancements
    bashInteractive
    
    # Media tools
    ffmpeg
    
    # Other utilities
    gum
    hurl
    sesh
    choose-gui
  ] ++ (with pkgs-stable; [
    # Stable CLI tools
    pandoc
    dive
    lazydocker
    lnav
    # Additional tools from homebrew audit
    go-task  # Task runner (if available in nixpkgs, otherwise use homebrew)
  ]);
}

