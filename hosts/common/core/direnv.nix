{ ... }:
{
  programs.direnv = {
    enable = true;
    # Faster, optimized direnv
    nix-direnv.enable = true;
  };
}
