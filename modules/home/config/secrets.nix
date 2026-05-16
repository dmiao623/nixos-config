{ config, lib, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

    secrets = {
      "git/email" = { };
      "tokens/openai" = { };
      "tokens/anthropic" = { };
    };

    templates = {
      "git-user-include".content = ''
        [user]
          email = ${config.sops.placeholder."git/email"}
      '';

      "api-tokens.env".content = ''
        export OPENAI_API_KEY="${config.sops.placeholder."tokens/openai"}"
        export ANTHROPIC_API_KEY="${config.sops.placeholder."tokens/anthropic"}"
      '';
    };
  };

  home.packages = with pkgs; [ sops ssh-to-age age ];
}
