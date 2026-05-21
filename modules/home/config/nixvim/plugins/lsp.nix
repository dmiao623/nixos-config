{ ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      bashls.enable = true;
      cssls.enable = true;
      html.enable = true;
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
      yamlls.enable = true;
    };

    keymaps = {
      lspBuf = {
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
      ];
    };

    postConfig = ''
      -- Clangd with custom compile-commands dir
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--compile-commands-dir=" .. vim.fn.expand("/home/dustinm/projects/cp/_library"),
          "--header-insertion=never",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
      })
      vim.lsp.enable("clangd")
    '';
  };
}
