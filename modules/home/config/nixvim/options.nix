{ ... }:

{
  programs.nixvim = {
    globals = {
      netrw_liststyle = 3;
      python_recommended_style = 0;
      # Disable the built-in OCaml ftplugin's buffer-local mappings, which
      # otherwise claim <LocalLeader>s/t/c (= Space s/t/c, since localleader is
      # Space) in .ml/.mli buffers and shadow our own leader keys. Space t there
      # triggered the legacy ".annot" type lookup that dune/merlin never produce.
      no_ocaml_maps = 1;
    };

    opts = {
      number = true;
      relativenumber = true;
      cursorline = true;

      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      wrap = false;

      ignorecase = true;
      smartcase = true;
      inccommand = "split";

      termguicolors = true;
      background = "dark";
      signcolumn = "yes";

      backspace = "indent,eol,start";
      clipboard = "unnamedplus";

      splitright = true;
      splitbelow = true;

      scrolloff = 8;
      sidescrolloff = 8;

      swapfile = false;
      backup = false;
      undofile = true;

      timeout = true;
      timeoutlen = 500;
    };

    autoCmd = [
      {
        event = [
          "BufRead"
          "BufNewFile"
        ];
        pattern = [
          "*.c0"
          "*.c1"
        ]; # 15-122 :<
        command = "set filetype=c";
      }
    ];

    extraConfigLua = ''
      vim.opt.iskeyword:append("-")
    '';
  };
}
