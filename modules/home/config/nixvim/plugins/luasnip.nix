{ ... }:

{
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      fromVscode = [ { } ];
    };

    friendly-snippets.enable = true;
  };
}
