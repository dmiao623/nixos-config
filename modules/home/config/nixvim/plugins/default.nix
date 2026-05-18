{ ... }:

{
  imports = [
    ./colorscheme.nix
    ./telescope.nix
    ./treesitter.nix
    ./lsp.nix
    ./gitsigns.nix
    ./comment.nix
    ./indent-blankline.nix
    ./oil-tree.nix
    ./cilantro.nix
  ];

  programs.nixvim.plugins.web-devicons.enable = true;
}
