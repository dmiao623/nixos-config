{ pkgs, ... }:

{
  imports = [
    ./nixvim/options.nix
    ./nixvim/keymaps.nix
    ./nixvim/plugins
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # tree-sitter CLI is required at runtime for parsers (e.g. latex) that
    # nvim-treesitter marks as needing regeneration to match nvim's parser ABI.
    extraPackages = [ pkgs.tree-sitter ];
  };
}
