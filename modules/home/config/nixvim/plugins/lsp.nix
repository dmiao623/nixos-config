{ ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      bashls.enable = true;
      jsonls.enable = true;
      ltex.enable = true;
      lua_ls = {
        enable = true;
        settings = {
          Lua.diagnostics.globals = [ "vim" ];
          Lua.completion.callSnippet = "Replace";
        };
      };
      marksman.enable = true;
      pyright.enable = true;
      ruff = {
        enable = true;
        onAttach.function = ''
          client.server_capabilities.hoverProvider = false
        '';
      };
      yamlls.enable = true;
    };

    keymaps = {
      lspBuf = {
        "K" = {
          action = "hover";
          desc = "(lsp) Show hover info";
        };
        "gD" = {
          action = "declaration";
          desc = "(lsp) Go to declaration";
        };
        "<leader>rn" = {
          action = "rename";
          desc = "(lsp) Smart rename";
        };
      };
      extra = [
        {
          mode = "n";
          key = "gR";
          action = "<cmd>Telescope lsp_references<CR>";
          options.desc = "(telescope, lsp) Show LSP references";
        }
        {
          mode = "n";
          key = "gd";
          action = "<cmd>Telescope lsp_definitions<CR>";
          options.desc = "(lsp) Show LSP definitions";
        }
        {
          mode = "n";
          key = "<leader>dk";
          action.__raw = "vim.diagnostic.goto_prev";
          options.desc = "(diagnostic) Go to previous diagnostic";
        }
        {
          mode = "n";
          key = "<leader>dj";
          action.__raw = "vim.diagnostic.goto_next";
          options.desc = "(diagnostic) Go to next diagnostic";
        }
        {
          mode = "n";
          key = "<leader>df";
          action.__raw = "vim.diagnostic.open_float";
          options.desc = "(diagnostic) Show diagnostic float";
        }
        {
          mode = "n";
          key = "<leader>do";
          action.__raw = "vim.diagnostic.setloclist";
          options.desc = "(diagnostic) Open diagnostics list";
        }
      ];
    };
  };
}
