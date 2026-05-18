{ config, lib, pkgs, ... }:

{
  home.file.".claude/settings.json" = {
    text = builtins.toJSON {
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
    };
  };
}