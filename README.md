# My (new) dotfiles

Steps on new system.

1. Install nix. Preferably using determinate-systems installer.
2. Setup nix-darwin first time: `nix run nix-darwin -- switch --flake ~/.config/nix-darwin`
3. Enjoy!

Too scared to commit `work.nix` to git so instead do:

```shell
git add --intent-to-add work.nix
```

and

```shell
git update-index --assume-unchanged work.nix
```

Undo: https://stackoverflow.com/questions/62444728/how-to-undo-git-add-intent-to-add

Monitor aerospace:

- https://github.com/nikitabobko/AeroSpace/issues/253
- https://github.com/nikitabobko/AeroSpace/issues/149#issuecomment-1928127037
