{
  inputs,
  pkgs,
  ...
}:
let
  json = pkgs.formats.json { };
in
{
  home.packages = [ inputs.nono.packages.${pkgs.stdenv.hostPlatform.system}.prebuilt ];

  xdg.configFile."nono/profiles/omp.json".source = json.generate "nono-omp-profile.json" {
    extends = "nolabs-ai/omp";
    meta = {
      name = "omp";
      description = "Oh My Pi, managed by home-manager";
    };
    groups.include = [
      "nix_runtime"
      "rust_runtime"
      "python_runtime"
      "node_runtime"
      "bun_runtime"
      "user_caches_linux"
      "linux_sysfs_read"
      "git_config"
      "unlink_protection"
    ];
    security = {
      signal_mode = "isolated";
      capability_elevation = false;
    };
    filesystem = {
      allow = [
        "$HOME/.omp"
      ];
      read = [
        "/etc/passwd"
        "$HOME/.agents/skills"
      ];
    };
    environment.set_vars.TMPDIR = "$HOME/.omp/tmp";
    network.block = false;
    workdir.access = "readwrite";
    rollback.exclude_patterns = [
      "node_modules"
      "target"
      "result"
      ".omp"
    ];
  };
  # Create an ephemeral tmp dir for the sandbox that clears after 7days
  systemd.user.tmpfiles.rules = [ "d %h/.omp/tmp 0700 - - 7d" ];

  # Direct agents to the tmp dir
  home.file.".omp/agent/RULES.md".text = ''
    Temporary files: use `$TMPDIR` (`~/.omp/tmp`), NEVER `/tmp` or `/var/tmp`; the nono sandbox blocks writes there. Applies to shell commands, scripts, `git clone`, `mktemp`, and tool output paths.
  '';

  programs.fish.shellAbbrs.ompn = "nono run --profile omp --allow-cwd -- omp";
}
