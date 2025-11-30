{ config, ... }:
{
  programs.git = {
    enable = true;

    # Better defaults, inspired by https://blog.gitbutler.com/how-git-core-devs-configure-git
    settings = {
      # Format branch names in columns
      column.ui = "auto";

      # Don't sort branches and tags alphabetically
      branch.sort = "-committerdate";
      tag.sort = "version:refname";

      # Use delta pager
      core.pager = "delta";

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
      user = {
        signingkey = "/home/${config.home.username}/.ssh/id_ed25519.pub";
        name = "Ole Tytlandsvik";
        email = "ole.tytlandsvik@gmail.com";
      };
      commit.gpgsign = true;
      alias = {
        # Stolen from https://stackoverflow.com/questions/1838873/visualizing-branch-topology-in-git/34467298#34467298
        history = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      };
    };
  };
}
