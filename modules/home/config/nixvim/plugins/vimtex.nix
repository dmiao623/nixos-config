{ ... }:

{
  programs.nixvim = {
    globals = {
      vimtex_view_method = "zathura";
      vimtex_compiler_method = "latexmk";
      vimtex_mappings_prefix = "<localleader>";
      vimtex_quickfix_mode = 0;
      vimtex_compiler_latexmk = {
        aux_dir = "";
        out_dir = "";
        callback = 1;
        continuous = 1;
        executable = "latexmk";
        hooks = [ ];
        options = [
          "-verbose"
          "-file-line-error"
          "-synctex=1"
          "-interaction=nonstopmode"
        ];
      };
    };

    plugins.vimtex = {
      enable = true;
      texlivePackage = null;
    };
  };
}
