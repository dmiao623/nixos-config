{ pkgs, ... }:

{
  programs.nixvim = {
    globals = {
      sonokai_enable_italic = true;
      sonokai_style = "shusia";
    };

    colorscheme = "sonokai";

    extraPlugins = [ pkgs.vimPlugins.sonokai ];
  };
}
