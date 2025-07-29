{ config, ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519
    '';
    matchBlocks = {
      # "ekman" = {
      #   hostname = "ekman.oceanbox.io";
      #   user = "oty";
      # };
    };
  };
  # OpenSSH private key agent
  services.ssh-agent.enable = true;
}
