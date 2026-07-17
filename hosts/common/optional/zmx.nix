{ inputs, system, ... }:
let
  unstable-pkgs = import inputs.nixpkgs-unstable { inherit system; };
in
{
  home.packages = [ unstable-pkgs.zmx ];
}
