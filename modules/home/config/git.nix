{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings.user.name = "dustinm";

    includes = [
      { path = config.sops.templates."git-user-include".path; }
    ];

    ignores = [
      ".DS_Store"
      ".claude/"
      ".vscode/"
    ];
  };

  programs.riff = {
    enable = true;
    enableGitIntegration = true;
  };
}
