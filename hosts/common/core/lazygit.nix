{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      # Configure delta as the default pager
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };
}
