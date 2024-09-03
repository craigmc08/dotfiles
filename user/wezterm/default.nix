{ lib, pkgs, config, ... }:

# TODO: FIX THIS. fonts arent rendering :(

with lib;
let cfg = config.modules.wezterm;

    # https://github.com/nix-community/nixGL/issues/114#issuecomment-1585323281
    # Wrap the package's binaries with nixGL, while preserving the rest of
    # the outputs and derivation attributes.
    nixglWrap = pkg:
      (pkg.overrideAttrs (old: {
        name = "nixGL-${pkg.name}";
        buildCommand = ''
          set -eo pipefail

          ${
          # Heavily inspired by https://stackoverflow.com/a/68523368/6259505
          pkgs.lib.concatStringsSep "\n" (map (outputName: ''
            echo "Copying output ${outputName}"
            set -x
            cp -rs --no-preserve=mode "${pkg.${outputName}}" "''$${outputName}"
            set +x
          '') (old.outputs or [ "out" ]))}

          rm -rf $out/bin/*
          shopt -s nullglob # Prevent loop from running if no files
          for file in ${pkg.out}/bin/*; do
            echo "#!${pkgs.bash}/bin/bash" > "$out/bin/$(basename $file)"
            echo "exec -a \"\$0\" ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel $file \"\$@\"" >> "$out/bin/$(basename $file)"
            chmod +x "$out/bin/$(basename $file)"
          done
          shopt -u nullglob # Revert nullglob back to its normal default state
        '';
      }));

in {
  options.modules.wezterm = { enable = mkEnableOption "wezterm"; };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      package = nixglWrap pkgs.wezterm;
      extraConfig = lib.readFile (./config.lua);
    };
  };
}

