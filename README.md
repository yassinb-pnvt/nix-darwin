# My (new) dotfiles

Steps on system, very based on the one that https://github.com/maxRN/nix-darwin did, in a very lightish way to avoid any bug. It will be changed as I learn nix and improve the whole repo to my needs. 

1. Install nix.
2. Setup nix-darwin first time: `nix run nix-darwin -- switch --flake ~/.config/nix-darwin` <- I had to add --impure and allow unsupported platforms in the configuration to make it work.
3. Enjoy!

## MacOS settings

- Disable language switcher pop-up: https://stackoverflow.com/questions/77248249/disable-macos-sonoma-text-insertion-point-cursor-caps-lock-indicator
```shell
sudo mkdir -p /Library/Preferences/FeatureFlags/Domain
sudo /usr/libexec/PlistBuddy -c "Add 'redesigned_text_cursor:Enabled' bool false" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

## Next steps:

- []: Correctly debug why Ghostty can't find fish without full path
- []: Adapt fish to a nix file rather than a full config folder added 
- []: Fix fzf (doesn't work in nvim and terminal) with fish for my functions 
- []: Adapt the aliases from fish config to nix
