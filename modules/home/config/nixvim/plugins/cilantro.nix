{ pkgs, cilantroNvim, ... }:

let
  cilantro-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "cilantro-nvim";
    src = cilantroNvim;
  };
in

{
  programs.nixvim = {
    extraPlugins = [ cilantro-plugin ];

    extraConfigLua = ''
      require("cilantro").setup({
        task_dir = "~/Cilantro",
        timezone = "-04:00",
        list_columns = { "status", "title" },
        layout = {
          ratio = { 1, 2, 2 },
          file_tree = "Oil",
        },
      })
    '';
  };
}
