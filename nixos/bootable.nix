{ ... }: {
  boot = {
    kernelParams = [ "consoleblank=30" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
