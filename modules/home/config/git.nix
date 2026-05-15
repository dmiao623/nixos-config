{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings.user = {
      name  = "dustinm";
      email = "dustinmmiao@gmail.com";
    };

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
