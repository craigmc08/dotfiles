## set up

Create `hosts/<hostname>/default.nix` and import at least `../../nixos`. Use an
existing host flake for inspiration.

Then, add it to `flake.nix` where the other hosts are listed.

Finally, run `./up`.

To update configuration, just run `./up` again, which also pulls most recent
version from origin.

To build, you must have flakes enabled and git installed.

## layout

- `hosts/` contains host-specific configuration.
- `nixos/` contains system configuration.
- `home/` contains home-manager configuration.

## thanks

Based off of https://github.com/forrestjacobs/dots.

