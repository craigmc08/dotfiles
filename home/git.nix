{ lib, pkgs, config, inputs, ... }: {
  programs.git = {
    enable = true;
    userName = "Craig McIlwrath";
    userEmail = lib.mkDefault "craigmc08@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    ignores = [
      ".env"
      "__scripts"
    ];
  };
}
