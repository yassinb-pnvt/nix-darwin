{ pkgs, ... }@args:
#############################################################
#
#  Host & Users configuration
#
#############################################################
let
  hostname = "MB-Q5JMWQ5VFD";
  username = "maxrn";
in {
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
