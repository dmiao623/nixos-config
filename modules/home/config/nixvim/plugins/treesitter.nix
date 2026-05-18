{ ... }:

{
  programs.nixvim.plugins.treesitter = {
    enable = true;

    settings = {
      highlight.enable = true;
      indent.enable = true;
      incremental_selection.enable = false;
      auto_install = false;
      ensure_installed = [
        "bash" "bibtex" "cpp" "json" "julia"
        "lua" "luadoc" "markdown" "markdown_inline"
        "python" "vim" "vimdoc" "yaml"
      ];
    };
  };
}
