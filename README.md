# initial setup

enable flakes in system config (add the following somewhere in `/etc/nixos/configuration.nix`)

```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

and rebuild system:

```sh
sudo nixos-rebuild switch
```

after cloning this repo, generate hardware config with

```sh
  TODO find this command
```

then, backup existing nixos config and link in this config

```sh
mv /etc/nixos /etc/nixos.bak
ln -s ~/dotfiles /etc/nixos
```

finally, rebuild the system:

```sh
sudo nixos-rebuild switch --flake /etc/nixos#lauma
```

(you may need to restart for the hostname to be updated, after that you won't
need to specify the flake anymore)

## other installation

genshin is installed via lutris, search for it and use the official installer.
