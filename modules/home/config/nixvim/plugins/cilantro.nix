{ pkgs, cilantroNvim, ... }:

let
  cilantro-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "cilantro-nvim";
    src  = cilantroNvim;
  };
in

{
  programs.nixvim = {
    extraPlugins = [ cilantro-plugin ];

    extraConfigLua = ''
      require("cilantro").setup({
        task_dir = "~/tasks",
      })
    '';
  };
}
