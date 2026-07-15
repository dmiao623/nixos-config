{
  config,
  lib,
  pkgs,
  ...
}:

let
  claudeSettings = pkgs.writeText "claude-settings.json" (builtins.toJSON {
    effortLevel = "medium";

    worktree = {
      baseRef = "head";
    };

    permissions = {
      additionalDirectories = [
        "/${config.home.homeDirectory}/Projects"
        "/${config.home.homeDirectory}/Downloads"
        "/${config.home.homeDirectory}/nixos-config"
      ];

      allow = [
        "Webfetch(*)"
        "Read(*)"

        "Bash(ls *)"
        "Bash(cd *)"
        "Bash(find *)"
        "Bash(stat *)"

        "Bash(mkdir *)"
        "Bash(echo *)"
        "Bash(touch *)"
        "Bash(cp *)"

        "Bash(git status *)"
        "Bash(git diff *)"
        "Bash(git log *)"
        "Bash(git branch *)"

        "Bash(* --version)"
        "Bash(* --help)"
      ];
    };
  });
in

{
  home.activation.claudeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run rm -f "$HOME/.claude/settings.json"
    run install -Dm644 ${claudeSettings} "$HOME/.claude/settings.json"
  '';

  home.file.".claude/keybindings.json" = {
    text = builtins.toJSON {
      "$schema" = "https://www.schemastore.org/claude-code-keybindings.json";
      "$docs" = "https://code.claude.com/docs/en/keybindings";
      bindings = [
        {
          context = "Chat";
          bindings = {
            "enter" = "chat:newline";
            "alt+enter" = "chat:submit";
          };
        }
      ];
    };
  };
}
