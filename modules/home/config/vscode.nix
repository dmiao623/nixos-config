{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        anthropic.claude-code
        jeff-hykin.better-nix-syntax
        vscode-icons-team.vscode-icons
        vscodevim.vim
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "sonokai";
          publisher = "sainnhe";
          version = "0.2.9";
          sha256 = "sha256-5b3XPCH6h8FYVyn6Iws2j7lIwHSaQE5glaBnmhGErIk=";
        }
      ];

      userSettings = {
        "chat.disableAIFeatures" = true;
        "claudeCode.preferredLocation" = "panel";
        "files.autoSave" = "onFocusChange";
        "files.exclude" = {
          "**/.venv/" = true;
          "**/__init__.py" = true;
          "**/__pycache__/" = true;
        };
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.suggestSmartCommit" = false;
        "editor.fontFamily" = "'FiraCode Nerd Font Mono'";
        "editor.fontSize" = 16;
        "editor.fontLigatures" = true;
        "editor.rulers" = [ 100 ]; 
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "vim.useSystemClipboard" = true;
        "workbench.colorTheme" = "Sonokai Shusia";
        "workbench.iconTheme" = "vscode-icons";
      };
    };
  };
}