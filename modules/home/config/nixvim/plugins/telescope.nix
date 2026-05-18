{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions.fzf-native.enable = true;

    settings.defaults = {
      path_display = [ "smart" ];
      mappings.i = {
        "<C-k>" = { __raw = "require('telescope.actions').move_selection_previous"; };
        "<C-j>" = { __raw = "require('telescope.actions').move_selection_next"; };
      };
    };

    keymaps = {
      "<leader>ff" = { action = "find_files"; options.desc = "(telescope) Fuzzy find files in cwd"; };
      "<leader>fg" = { action = "live_grep";  options.desc = "(telescope) Fuzzy find string in cwd"; };
    };
  };
}
