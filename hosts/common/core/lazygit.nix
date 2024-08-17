{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      # Configure delta as the default pager
      git.paging = {
        colorArg = "always";
        # TODO: Add back delta once build error is fixed
        # pager = "delta --dark --paging=never";
      };
    };
  };
}
