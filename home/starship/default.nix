{ config, pkgs, ... }:

let jj_status = pkgs.writeShellScript "jj_status.sh" ''
  set -euo pipefail

  jjt() {
    jj --ignore-working-copy log -r @ --no-graph -T "$1"
  }

  printf '\e[30m'
  printf '\e[37;40m '
  jjt 'change_id.shortest() ++ "←" ++ parents.map(|c| c.change_id().shortest()).join(",")'

  bookmarks="$(jjt 'bookmarks')"
  if [ -n "$bookmarks" ]; then
    printf " (%s)" "$bookmarks"
  fi

  if jjt 'conflict' | grep true > /dev/null; then
    printf '\e[91m !'
  fi

  printf '\e[0;30m\e[0m'
'';
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = 
      "$username" +
      "$directory " +
      "\${custom.jj}" +
      "$hg_branch" +
      "$kubernetes" +
      "$docker_context" +
      "$package" +
      "$cmake" +
      "$dart" +
      "$dotnet" +
      "$elixir" +
      "$elm" +
      "$erlang" +
      "$golang" +
      "$helm" +
      "$java" +
      "$julia" +
      "$kotlin" +
      "$nim" +
      "$nodejs" +
      "$ocaml" +
      "$perl" +
      "$php" +
      "$purescript" +
      "$python" +
      "$ruby" +
      "$rust" +
      "$swift" +
      "$terraform" +
      "$vagrant" +
      "$zig" +
      "$nix_shell" +
      "$conda" +
      "$aws" +
      "$gcloud" +
      "$openstack" +
      "$env_var" +
      "$crystal" +
      "$custom" +
      "$cmd_duration" +
      "$lua" +
      "$line_break" +
      "$jobs" +
      "$status" +
      "$character";

      character.success_symbol = "[](green)";
      character.error_symbol = "[](bright-red)";

      fill.symbol = " ";

      username.style_user = "bright-purple bold";
      username.style_root = "birhg-red bold";
      username.format = "[$user]($style) ";
      username.disabled = false;

      directory.format = "[$path](bold bright-blue)";
      directory.truncation_length = 3;
      directory.truncation_symbol = "…/";
      directory.home_symbol = "~";
      directory.read_only = " ";

      custom.jj.description = "Shows information about status of current JJ repo.";
      custom.jj.when = "jj --ignore-working-copy root";
      custom.jj.shell = ["bash" "--noprofile" "--norc"];
      custom.jj.command = "${jj_status}";
      custom.jj.format = "$output ";
      custom.jj.unsafe_no_escape = true;

      gcloud.symbol = "󱇶 ";
      gcloud.disabled = false;

      aws.symbol = "  ";

      buf.symbol = " ";

      c.symbol = " ";

      conda.symbol = " ";

      crystal.symbol = " ";

      dart.symbol = " ";

      docker_context.symbol = " ";

      elixir.symbol = " ";

      elm.symbol = " ";

      fennel.symbol = " ";

      fossil_branch.symbol = " ";

      git_branch.symbol = " ";
      git_branch.disabled = true;

      git_commit.tag_symbol = "  ";
      git_commit.disabled = true;

      git_state.disabled = true;
      
      git_status.disabled = true;

      golang.symbol = " ";

      guix_shell.symbol = " ";

      haskell.symbol = " ";

      haxe.symbol = " ";

      hg_branch.symbol = " ";

      hostname.ssh_symbol = " ";

      java.symbol = " ";

      julia.symbol = " ";

      kotlin.symbol = " ";

      lua.symbol = " ";

      memory_usage.symbol = "󰍛 ";

      meson.symbol = "󰔷 ";

      nim.symbol = "󰆥 ";

      nix_shell.symbol = " ";

      nodejs.symbol = " ";

      ocaml.symbol = " ";

      os.symbols.Alpaquita = " ";
      os.symbols.Alpine = " ";
      os.symbols.AlmaLinux = " ";
      os.symbols.Amazon = " ";
      os.symbols.Android = " ";
      os.symbols.Arch = " ";
      os.symbols.Artix = " ";
      os.symbols.CentOS = " ";
      os.symbols.Debian = " ";
      os.symbols.DragonFly = " ";
      os.symbols.Emscripten = " ";
      os.symbols.EndeavourOS = " ";
      os.symbols.Fedora = " ";
      os.symbols.FreeBSD = " ";
      os.symbols.Garuda = "󰛓 ";
      os.symbols.Gentoo = " ";
      os.symbols.HardenedBSD = "󰞌 ";
      os.symbols.Illumos = "󰈸 ";
      os.symbols.Kali = " ";
      os.symbols.Linux = " ";
      os.symbols.Mabox = " ";
      os.symbols.Macos = " ";
      os.symbols.Manjaro = " ";
      os.symbols.Mariner = " ";
      os.symbols.MidnightBSD = " ";
      os.symbols.Mint = " ";
      os.symbols.NetBSD = " ";
      os.symbols.NixOS = " ";
      os.symbols.OpenBSD = "󰈺 ";
      os.symbols.openSUSE = " ";
      os.symbols.OracleLinux = "󰌷 ";
      os.symbols.Pop = " ";
      os.symbols.Raspbian = " ";
      os.symbols.Redhat = " ";
      os.symbols.RedHatEnterprise = " ";
      os.symbols.RockyLinux = " ";
      os.symbols.Redox = "󰀘 ";
      os.symbols.Solus = "󰠳 ";
      os.symbols.SUSE = " ";
      os.symbols.Ubuntu = " ";
      os.symbols.Unknown = " ";
      os.symbols.Void = " ";
      os.symbols.Windows = "󰍲 ";

      package.symbol = "󰏗 ";

      perl.symbol = " ";

      php.symbol = " ";

      pijul_channel.symbol = " ";

      python.symbol = " ";

      rlang.symbol = "󰟔 ";

      ruby.symbol = " ";

      rust.symbol = "󱘗 ";

      scala.symbol = " ";

      swift.symbol = " ";

      zig.symbol = " ";

      gradle.symbol = " ";
    };
  };

}
