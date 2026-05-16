{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        anthropic.claude-code
        jeff-hykin.better-nix-syntax
        enkia.tokyo-night
        vscode-icons-team.vscode-icons
        vscodevim.vim
      ];

      userSettings = {
        "chat.disableAIFeatures" = true;
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
        "workbench.colorTheme" = "Tokyo Night Light";
        "workbench.iconTheme" = "vscode-icons";
      };
    };
  };
}