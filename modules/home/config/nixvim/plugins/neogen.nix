{ ... }:

{
  programs.nixvim = {
    plugins.neogen = {
      enable = true;
      settings = {
        enabled = true;
        languages.python.template.annotation_convention = "google_docstrings";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>nd";
        action = "<cmd>Neogen<CR>";
        options.desc = "(neogen) Generate docstring";
      }
    ];
  };
}
