## set up

Create `hosts/<hostname>/default.nix` and import at least `../../nixos`. Use an
existing host flake for inspiration.

Then, add it to `flake.nix` where the other hosts are listed.

```sh
sudo nixos-rebuild switch --flake dotfiles
```

## layout

- `hosts/` contains host-specific configuration.
- `nixos/` contains system configuration.
- `home/` contains home-manager configuration.

## thanks

Based off of https://github.com/forrestjacobs/dots.

