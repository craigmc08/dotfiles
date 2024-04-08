## set up

__Prerequisites:__

- [Nix flakes](https://nixos.wiki/wiki/flakes)
- Root access

1. Clone the repo

```sh
git clone https://github.com/craigmc08/dotfiles ~/dotfiles && cd ~/dotfiles
```

> [!NOTE]
> If you're not me, there's a couple of extra steps to do: change the `origin` remote URL to a new repo you own. Then, in `flake.nix` change where it says `user.craig` to `user.<your username>`: https://github.com/craigmc08/dotfiles/blob/a37fa3c4af2900d75e6c350088f70a9e103f5ee2/flake.nix#L61
> Also change the user in `system/default.nix`: https://github.com/craigmc08/dotfiles/blob/a37fa3c4af2900d75e6c350088f70a9e103f5ee2/system/default.nix#L48
> You probably will also want to delete the other host files and the relevant sections in `flake.nix` after your finished taking "inspiration" from them.

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

7. Add an entry to `nixosConfigurations` in `flake.nix` for your new host (just copy an existing one and change the two places where the hostname is written).

8. `git add` the changed files.

9. `./up` to build the system with the new configuration.

Whenever you want to update your system, run `./up` to pull changes from the
origin remote and rebuild.

## layout

- `hosts/` contains host-specific configuration.
- `system/` contains system configuration.
- `user/` contains home-manager configuration for individual programs.

### adding new user programs

The way the `user` files work is they expose a bit of config for a program. At the bare minimum, this would be a `mkEnableOption` to turn the program on and off. To add a new one:

1. Copy a simple existing one (like `users/direnv`) into a new folder with a name of your choosing, although basing it off the name of the program it installs is recommended.

2. Replace all the places that used the previous program name with the new one.

3. In the `mkIf cfg.enable` section, add `home-manager` configuration settings to install/configure the desired program.

4. Import your new config file into `users/default`, and enable it in the desired hosts' `user.nix` files.

### system configuration

This part of my config isn't as refined yet. For now, I've just been kind of adding ad-hoc configuration parameters in the `system/default.nix` file.

## thanks

- https://github.com/forrestjacobs/dots
- https://github.com/notusknot/dotfiles-nix
- EWW modules from https://github.com/fufexan/dotfiles/blob/main/home/programs/eww

