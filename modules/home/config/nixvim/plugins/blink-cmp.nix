{ ... }:

{
  programs.nixvim.plugins.blink-cmp = {
    enable = true;

    settings = {
      snippets.preset = "luasnip";

      sources.default = [ "lsp" "path" "snippets" "buffer" ];

      completion.documentation.auto_show = true;

      keymap = {
        preset = "none";
        "<C-Space>" = [ "show" "show_documentation" ];
        "<C-e>" = [ "hide" ];
        "<Tab>" = [ "accept" "snippet_forward" "fallback" ];
        "<C-k>" = [ "select_prev" "fallback" ];
        "<C-j>" = [ "select_next" "fallback" ];
        "<C-d>" = [ "scroll_documentation_down" "fallback" ];
        "<C-u>" = [ "scroll_documentation_up" "fallback" ];
      };
    };
  };
}
