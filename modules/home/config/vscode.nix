{
  pkgs,
  ...
}:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          anthropic.claude-code
          james-yu.latex-workshop
          jnoortheen.nix-ide
          mkhl.direnv
          ms-python.debugpy
          ms-python.python
          ms-python.vscode-pylance
          ms-toolsai.jupyter
          ms-toolsai.jupyter-keymap
          ms-toolsai.jupyter-renderers
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.vscode-jupyter-slideshow
          vscode-icons-team.vscode-icons
          vscodevim.vim
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "sonokai";
            publisher = "sainnhe";
            version = "0.2.9";
            sha256 = "sha256-5b3XPCH6h8FYVyn6Iws2j7lIwHSaQE5glaBnmhGErIk=";
          }
          {
            name = "vscode-python-envs";
            publisher = "ms-python";
            version = "1.30.0";
            sha256 = "0mpsn1bkcxnyf0kki4xfmvslgdpipn0bwf4xl45afwfxw25rp5l7";
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
        "editor.minimap.enabled" = false;
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "vim.useSystemClipboard" = true;
        "vim.handleKeys" = {
          "<C-c>" = false;
          "<C-v>" = false;
          "<C-a>" = false;
          "<C-x>" = false;
          "<C-w>" = true;
          "<M-h>" = false;
          "<M-l>" = false;
        };
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            before = [
              "<C-w>"
              "h"
            ];
            commands = [ "workbench.action.focusLeftGroup" ];
          }
          {
            before = [
              "<C-w>"
              "j"
            ];
            commands = [ "workbench.action.focusBelowGroup" ];
          }
          {
            before = [
              "<C-w>"
              "k"
            ];
            commands = [ "workbench.action.focusAboveGroup" ];
          }
          {
            before = [
              "<C-w>"
              "l"
            ];
            commands = [ "workbench.action.focusRightGroup" ];
          }
        ];
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "${pkgs.nixfmt}/bin/nixfmt" ];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"/home/dustinm/nixos-config\").nixosConfigurations.nixos.options";
              };
              "home-manager" = {
                "expr" =
                  "(builtins.getFlake \"/home/dustinm/nixos-config\").nixosConfigurations.nixos.config.home-manager.users.dustinm.options";
              };
            };
          };
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
        {
          key = "cmd+w";
          command = "workbench.action.closeActiveEditor";
        }
        {
          key = "cmd+w";
          command = "workbench.action.closeGroup";
          when = "activeEditorGroupEmpty";
        }
        {
          key = "cmd+shift+w";
          command = "workbench.action.closeWindow";
        }
        {
          key = "ctrl+w";
          command = "-workbench.action.closeActiveEditor";
        }
        {
          key = "ctrl+w";
          command = "-workbench.action.closeGroup";
          when = "activeEditorGroupEmpty";
        }
        {
          key = "ctrl+shift+w";
          command = "-workbench.action.closeWindow";
        }
        {
          key = "ctrl+w ctrl+h";
          command = "workbench.action.focusLeftGroup";
        }
        {
          key = "ctrl+w ctrl+j";
          command = "workbench.action.focusBelowGroup";
        }
        {
          key = "ctrl+w ctrl+k";
          command = "workbench.action.focusAboveGroup";
        }
        {
          key = "ctrl+w ctrl+l";
          command = "workbench.action.focusRightGroup";
        }
        {
          key = "ctrl+shift+c";
          command = "claude-vscode.editor.open";
        }
        # Tab switching (cmd + number row: & [ { ( = * ) + ] on Programmer Dvorak)
        {
          key = "cmd+1";
          command = "workbench.action.openEditorAtIndex1";
        }
        {
          key = "cmd+2";
          command = "workbench.action.openEditorAtIndex2";
        }
        {
          key = "cmd+3";
          command = "workbench.action.openEditorAtIndex3";
        }
        {
          key = "cmd+4";
          command = "workbench.action.openEditorAtIndex4";
        }
        {
          key = "cmd+5";
          command = "workbench.action.openEditorAtIndex5";
        }
        {
          key = "cmd+6";
          command = "workbench.action.openEditorAtIndex6";
        }
        {
          key = "cmd+7";
          command = "workbench.action.openEditorAtIndex7";
        }
        {
          key = "cmd+8";
          command = "workbench.action.openEditorAtIndex8";
        }
        {
          key = "cmd+9";
          command = "workbench.action.openEditorAtIndex9";
        }
        # Previous/next tab
        {
          key = "alt+h";
          command = "workbench.action.previousEditor";
        }
        {
          key = "alt+l";
          command = "workbench.action.nextEditor";
        }
      ];
    };
  };
}
