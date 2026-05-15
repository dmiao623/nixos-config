{ config, lib, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

    secrets."git/email" = { };

    templates."git-user-include".content = ''
      [user]
        email = ${config.sops.placeholder."git/email"}
    '';
  };

  home.packages = with pkgs; [ sops ssh-to-age age ];
}
