{ config, pkgs, ... }: {
  # X11
  services.xserver.enable = true;

  # Pantheon
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Pipewire (for soujnd)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
