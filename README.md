## set up

__Prerequisites:__

- [Nix flakes](https://nixos.wiki/wiki/flakes)
- Root access

1. Clone the repo

```sh
git clone https://github.com/craigmc08/dotfiles ~/dotfiles && cd ~/dotfiles
```

2. Create the hardware configuration for your system:

```sh
sudo nixos-generate-config
```

3. Copy into the hosts directory for the `<hostname>` you want your computer to have:

```sh
mkdir hosts/<hostname>
cp /etc/nixos/hardware-configuration.nix hosts/<hostname>/hardware-configuration.nix
```

4. Make `hosts/<hostname>/system.nix` and import at least `../../system`. You can
  also put system-specific configuration here. Use an existing host for inspiration!

5. Also make `hosts/<hostname>/user.nix` and import at least `../../user`. Use an
  existing host for inspiration to see what kinds of programs and config options are available.

7. Add an entry to `nixosConfigurations` in `flake.nix` for your new host.

8. `git add` the changed files.

9. `./up` to build the system with the new configuration.

Whenever you want to update your system, run `./up` to pull changes from the
origin remote and rebuild.

## layout

- `hosts/` contains host-specific configuration.
- `system/` contains system configuration.
- `user/` contains home-manager configuration for individual programs.

## thanks

- https://github.com/forrestjacobs/dots
- https://github.com/notusknot/dotfiles-nix
- EWW modules from https://github.com/fufexan/dotfiles/blob/main/home/programs/eww

