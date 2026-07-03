{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions.fzf-native.enable = true;
    extensions.ui-select.enable = true;

    settings.defaults = {
      file_ignore_patterns = [
        ".git/"
        "node_modules/"
        "result/"
        ".venv/"
        ".vscode/"
        ".direnv/"
        ".claude/"
      ];
      path_display = [ "smart" ];
      mappings.i = {
        "<C-k>" = {
          __raw = "require('telescope.actions').move_selection_previous";
        };
        "<C-j>" = {
          __raw = "require('telescope.actions').move_selection_next";
        };
      };
    };

    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "(telescope) Fuzzy find files in cwd";
      };
      "<leader>fg" = {
        action = "live_grep";
        options.desc = "(telescope) Fuzzy find string in cwd";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "(telescope) Find open buffers";
      };
      "<leader>fd" = {
        action = "diagnostics";
        options.desc = "(telescope) Find diagnostics";
      };
    };
  };
}
