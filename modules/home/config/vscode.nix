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
        "vim.handleKeys" = {
          "<C-c>" = false;
          "<C-v>" = false;
          "<C-a>" = false;
          "<C-x>" = false;
        };
        "workbench.colorTheme" = "Sonokai Shusia";
        "workbench.iconTheme" = "vscode-icons";
      };

      keybindings = [
        {
          key = "cmd+c";
          command = "editor.action.clipboardCopyAction";
        }
        {
          key = "cmd+v";
          command = "editor.action.clipboardPasteAction";
        }
        {
          key = "cmd+c";
          command = "workbench.action.terminal.copySelection";
          when = "terminalFocus";
        }
        {
          key = "cmd+v";
          command = "workbench.action.terminal.paste";
          when = "terminalFocus";
        }
        {
          key = "ctrl+c";
          command = "-editor.action.clipboardCopyAction";
        }
        {
          key = "ctrl+v";
          command = "-editor.action.clipboardPasteAction";
        }
        {
          key = "ctrl+shift+c";
          command = "-workbench.action.terminal.copySelection";
          when = "terminalFocus";
        }
        {
          key = "ctrl+shift+v";
          command = "-workbench.action.terminal.paste";
          when = "terminalFocus";
        }
        {
          key = "shift+insert";
          command = "-workbench.action.terminal.pasteSelection";
          when = "terminalFocus";
        }
      ];
    };
  };
}