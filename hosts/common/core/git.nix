{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Ole Tytlandsvik";
    userEmail = "ole.tytlandsvik@gmail.com";

    # Better defaults, inspired by https://blog.gitbutler.com/how-git-core-devs-configure-git
    extraConfig = {
      init.defaultBranch = "master";

      # Format branch names in columns
      column.ui = "auto";

      # Don't sort branches and tags alphabetically
      branch.sort = "-committerdate";
      tag.sort = "version:refname";

      diff = {
        # Better algorithm for 'git diff'
        algorithm = "histogram";
        # Distinguish moved code with separate colors
        colorMoved = "plain";
        # Detect renamed files
        renames = true;
      };

      push = {
        # Push branch to the same name on remote
        default = "simple";
        # Automatically setup tracking branch on remote (--set-upstream origin ...)
        autoSetupRemote = true;
      };

      fetch = {
        # Delete branches and tags that were deleted on remote
        prune = true;
        pruneTags = true;
        # Always fetch all
        all = true;
      };

      # Attempt to correct mistyped commands, but prompt before running
      help.autocorrect = "prompt";

      # Reuse recorded resolutions
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      # Sign commits with SSH key
      gpg = {
        format = "ssh";
        # NOTE: This file has to be created and populated with the pub key!
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      user.signingkey = "/home/${config.home.username}/.ssh/id_ed25519.pub";
    };
  };
}
