{
  pkgs,
  lib,
  config,
  options,
  ...
}:
let
  python = pkgs.python3;
  fish = lib.getExe config.programs.fish.package;

  # Run fish with --no-config under nono, so it doesn't spam errors
  ompShell = pkgs.writeShellScriptBin "fish" ''
    if [ -n "''${NONO_CAP_FILE:-}" ]; then
      exec ${fish} --no-config "$@"
    fi
    exec ${fish} "$@"
  '';
in
{
  programs.omp = {
    enable = true;
    settings = {
      tools.approvalMode = "always-ask";
      astGrep.enabled = true;

      setupVersion = 2;
      modelRoles = { };
      symbolPreset = "nerd";
      composer.shape = "band";
      theme.dark = "titanium";
      shellPath = "${ompShell}/bin/fish";
    };
    # Include a python interpreter for omp to use
    package = pkgs.symlinkJoin {
      name = "omp-with-python";
      paths = [ options.programs.omp.package.default ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/omp --suffix PATH : ${lib.makeBinPath [ python ]}
      '';
    };
  };
}
