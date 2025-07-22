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
    systemPackages =  [
      pkgs.ansible
      pkgs.awscli2
      pkgs._1password-cli 
      (pkgs.python3.withPackages (ps: [
        ps.boto3
        ps.datadog
        ps.requests
        ps.botocore
        ps.boto3
        ps.pyyaml
      ]))
    ];

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
     "spotifyd"
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
    defaults = {
      smb.NetBIOSName = hostname;
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
      finder = {
       AppleShowAllExtensions = true;
       FXEnableExtensionChangeWarning = false;
       CreateDesktop = false; # disable desktop icons
     };
    loginwindow = {
       GuestEnabled = false;
       DisableConsoleAccess = true;
     };
     SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
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
       _HIHideMenuBar = true;
     };
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

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
