{ ... }:

{
  programs.nixvim.plugins.vimtex = {
    enable = true;
    texlivePackage = null;

    settings = {
      view_method = "zathura_simple";
      compiler_method = "latexmk";
      quickfix_mode = 0;
      compiler_latexmk = {
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
  };
}
