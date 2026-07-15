{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      # Order of the first line, then a line break, then the prompt char.
      format = "$nix_shell$python$directory$git_branch$cmd_duration$line_break$character";

      # --- shell name(s) ---
      nix_shell = {
        # $name is the nix shell/flake devShell name; drop symbol/state for a clean name
        format = "[$name]($style) ";
        style = "bold blue";
      };

      python = {
        # show ONLY the venv name, not the python version
        format = "[$virtualenv]($style) ";
        style = "bold green";
      };

      # --- path relative to repo root ---
      directory = {
        truncate_to_repo = true; # start the path at the git repo root
        truncation_length = 0; # 0 = no further truncation, show the whole repo-relative path
        format = "[$path]($style) ";
        style = "bold cyan";
      };

      # --- git branch ---
      git_branch = {
        # default symbol  is a Nerd Font glyph
        format = "on [$symbol$branch]($style) ";
        style = "bold purple";
      };

      # --- command duration ---
      cmd_duration = {
        min_time = 2000; # only show for commands slower than 2s
        format = "[\\[ $duration \\]]($style)"; # the \\[ \\] render literal brackets: [ 15s ]
        style = "bold yellow";
      };

      # --- prompt character (second line) ---
      character = {
        success_symbol = "[#](bold green)"; # default / insert mode, last cmd OK
        error_symbol = "[#](bold red)"; # default / insert mode, last cmd failed
        vicmd_symbol = "[!](bold yellow)"; # vi normal ("command") mode
      };
    };
  };
}
