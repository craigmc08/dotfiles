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

### quicken

Run `./tools/quicken_install.sh`.

TODO: running quicken crashes with

```
Unhandled Exception:
System.ArgumentException: Invalid pipe name.
Parameter name: portName
  at System.Runtime.Remoting.Channels.Ipc.Win32.IpcServerChannel..ctor (System.Collections.IDictionary properties, System.Runtime.Remoting.Channels.IServerChannelSinkProvider provider) [0x000c2] in <d9c642f8d18540c9afe6ddbbe230e1cf>:0
  at System.Runtime.Remoting.Channels.Ipc.IpcServerChannel..ctor (System.Collections.IDictionary properties, System.Runtime.Remoting.Channels.IServerChannelSinkProvider sinkProvider) [0x00034] in <d9c642f8d18540c9afe6ddbbe230e1cf>:0
  at Quicken.Map.Helpers.SingleInstance.CreateRemoteService (System.String channelName) [0x0003b] in <48e40c46d5ff4baf82181664f4b23a6b>:0
  at Quicken.Map.Helpers.SingleInstance.InitializeSingleInstance (System.String mutexName, System.String channelName) [0x0001e] in <48e40c46d5ff4baf82181664f4b23a6b>:0
  at Quicken.Map.Helpers.SingleInstance.InitializeQuicken () [0x00015] in <48e40c46d5ff4baf82181664f4b23a6b>:0
  at <Module>.QuickenManagedHandler.QuickenManagedHandle.CreateRemoteService () [0x00005] in <714a7876c7c74e8a9f5f9178a6b4132c>:0
  at (wrapper native-to-managed) <Module>.QuickenManagedHandler.QuickenManagedHandle.CreateRemoteService()
  at (wrapper managed-to-native) <Module>._WinMainCRTStartup()
[ERROR] FATAL UNHANDLED EXCEPTION: System.ArgumentException: Invalid pipe name.
Parameter name: portName
  at System.Runtime.Remoting.Channels.Ipc.Win32.IpcServerChannel..ctor (System.Collections.IDictionary properties, System.Runtime.Remoting.Channels.IServerChannelSinkProvider provider) [0x000c2] in <d9c642f8d18540c9afe6ddbbe230e1cf>:0
  at System.Runtime.Remoting.Channels.Ipc.IpcServerChannel..ctor (System.Collections.IDictionary properties, System.Runtime.Remoting.Channels.IServerChannelSinkProvider sinkProvider) [0x00034] in <d9c642f8d18540c9afe6ddbbe230e1cf>:0
  at Quicken.Map.Helpers.SingleInstance.CreateRemoteService (System.String channelName) [0x0003b] in <48e40c46d5ff4baf82181664f4b23a6b>:0
  at Quicken.Map.Helpers.SingleInstance.InitializeSingleInstance (System.String mutexName, System.String channelName) [0x0001e] in <48e40c46d5ff4baf82181664f4b23a6b>:0
  at Quicken.Map.Helpers.SingleInstance.InitializeQuicken () [0x00015] in <48e40c46d5ff4baf82181664f4b23a6b>:0
  at <Module>.QuickenManagedHandler.QuickenManagedHandle.CreateRemoteService () [0x00005] in <714a7876c7c74e8a9f5f9178a6b4132c>:0
  at (wrapper native-to-managed) <Module>.QuickenManagedHandler.QuickenManagedHandle.CreateRemoteService()
```
