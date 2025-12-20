{ pkgs, ... }:
let
  hostname = "Yassins-MacBook-Air";
  username = "yassin.bousaadi";
in
{
  imports = [ 
    ../../modules/configuration.nix
  ];
  
  # macOS system defaults configuration
  system.defaults = {
    # SMB Configuration
    smb.NetBIOSName = hostname;
    
    # Dock Configuration
    dock = {
      autohide = true;
      orientation = "bottom";
      showhidden = true;
      mineffect = "genie";
      launchanim = true;
      show-process-indicators = true;
      tilesize = 48;
      static-only = true;
      mru-spaces = false;
      show-recents = false;
    };
    
    # Finder Configuration
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      CreateDesktop = false; # disable desktop icons
    };
    
    # Login Window Configuration
    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };
    
    # Software Update Configuration
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    
    # Global Domain (System-wide) Settings
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark"; # set dark mode
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSWindowShouldDragOnGesture = true;
      _HIHideMenuBar = true;
    };
    
    # Custom User Preferences (for settings not directly supported)
    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
    };
  };
  
  # Homebrew configuration
  homebrew = {
    enable = true;
    
    taps = [
      "FelixKratz/formulae"
      "nikitabobko/tap"
    ];
    
    # CLI tools/formulas
    brews = [
      # Window management
      "borders"
      
      # Remote desktop
      "freerdp"
      
      # Media/Streaming
      "spotifyd"
      
      # Security tools
      "john"
      "mkcert"
      
      # Network tools
      "upcloud-cli"
      "yt-dlp"
      
      # Development tools
      "go-task"
      "deno"
    ];
    
    # GUI Applications (casks)
    casks = [
      # Window management
      "nikitabobko/tap/aerospace"
      
      # Browsers
      "librewolf"
      
      # Development tools
      "dbeaver-community"
      "cursor"
      
      # Productivity
      "obsidian"
      "raycast"
      
      # Utilities
      "localsend"
      "openmtp"
      
      # Network tools
      "wireshark-app"
    ];
  };
  
  environment = {
    variables = {

    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh.enable = true; 
    fish.enable = true;
    # Disable _1password-gui since 1Password is already installed manually
    # This prevents permission errors when nix-darwin tries to manage it
    # _1password-gui.enable = true;
    _1password.enable = true;
  };
  
  # Used for backwards compatibility, please read the changelog before changing.
  system = {
    stateVersion = 4;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

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
