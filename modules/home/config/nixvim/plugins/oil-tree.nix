{ pkgs, oilTreeNvim, ... }:

let
  oil-tree-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "oil-tree-nvim";
    src  = oilTreeNvim;
  };
in

{
  programs.nixvim = {
    extraPlugins = [
      oil-tree-plugin
      pkgs.vimPlugins.nvim-web-devicons
    ];

    extraConfigLua = ''
      require("oil-tree").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            return name == ".DS_Store"
          end,
        },
        tree = {
          default_view = "tree",
          indent = 2,
        },
      })
    '';
  };
}
