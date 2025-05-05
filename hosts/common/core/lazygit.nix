{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      # Configure delta as the default pager
      git = {
        # Avoid exiting lazygit to enter passphrase for signing key
        overrideGpg = true;
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}
