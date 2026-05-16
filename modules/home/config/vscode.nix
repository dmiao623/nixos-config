{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscode-icons-team.vscode-icons
        vscodevim.vim
      ];

      userSettings = {
        "workbench.iconTheme" = "vscode-icons";
        "vim.useSystemClipboard" = true;
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
      };
    };
  };
}