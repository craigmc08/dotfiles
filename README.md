# initial setup

enable flakes in system config (add the following somewhere in `/etc/nixos/configuration.nix`)

```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

and rebuild system:

```sh
sudo nixos-rebuild switch
```

after cloning this repo, setup the host-specific config. choose an existing one
to clone from, and then generate hardware config.

```sh
# `lauma` is the host to copy config from, you can update it later if desired.
cp -r host/lauma host/<hostname>
nixos-generate-config --show-hardware-config > host/<hostname>/hardware-config.nix
```

then, backup existing nixos config and link in this config

```sh
mv /etc/nixos /etc/nixos.bak
ln -s ~/dotfiles /etc/nixos
```

finally, rebuild the system:

```sh
sudo nixos-rebuild switch --flake /etc/nixos#<hostname>
```

(you may need to restart for the hostname to be updated, after that you won't
need to specify the flake anymore)

## other installation

genshin is installed via lutris, search for it and use the official installer.
