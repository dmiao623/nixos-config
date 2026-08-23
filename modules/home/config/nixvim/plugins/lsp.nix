{ ... }:

{
  programs.nixvim.extraConfigLua = ''
    vim.lsp.inlay_hint.enable(true)

    -- Switch between source and interface/header by filename, on disk.
    function _G.switch_source_file()
      local path = vim.api.nvim_buf_get_name(0)
      if path == "" then
        vim.notify("switch: no file in buffer", vim.log.levels.WARN)
        return
      end

      local dir = vim.fn.fnamemodify(path, ":h")
      local stem = vim.fn.fnamemodify(path, ":t:r")
      local ext = vim.fn.fnamemodify(path, ":e")

      -- Ordered candidate counterpart extensions per source extension.
      local counterparts = {
        ml = { "mli" },
        mli = { "ml" },
        mll = { "mli" },
        mly = { "mli" },
        c = { "h" },
        cc = { "hh", "hpp", "h" },
        cpp = { "hpp", "hh", "h" },
        cxx = { "hxx", "hpp", "h" },
        h = { "c", "cpp", "cc", "cxx" },
        hh = { "cc", "cpp", "cxx" },
        hpp = { "cpp", "cc", "cxx" },
        hxx = { "cxx", "cpp", "cc" },
      }

      local candidates = counterparts[ext]
      if not candidates then
        vim.notify("switch: no rule for ." .. ext, vim.log.levels.INFO)
        return
      end

      for _, cext in ipairs(candidates) do
        local target = dir .. "/" .. stem .. "." .. cext
        if vim.fn.filereadable(target) == 1 then
          vim.cmd.edit(target)
          return
        end
      end

      vim.notify("switch: no counterpart for " .. stem .. "." .. ext, vim.log.levels.INFO)
    end
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gt";
      action = "<cmd>lua _G.switch_source_file()<CR>";
      options.desc = "Switch source/interface (.ml/.mli, .c/.h) by filename";
    }
  ];

  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      bashls.enable = true;
      clangd.enable = true;
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
      ocamllsp = {
        enable = true;
        settings = {
          inlayHints = {
            hintPatternVariables = true;
            hintLetBindings = true;
          };
        };
      };
      pyright = {
        enable = true;
        settings = {
          python.analysis.inlayHints = {
            variableTypes = true;
            functionReturnTypes = true;
            callArgumentNames = true;
            pytestParameters = true;
          };
        };
      };
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
        "<leader>gk" = {
          action = "hover";
          desc = "(lsp) Show hover info";
        };
        "<leader>gD" = {
          action = "declaration";
          desc = "(lsp) Go to declaration";
        };
        "<leader>gR" = {
          action = "rename";
          desc = "(lsp) Smart rename";
        };
      };
      extra = [
        {
          mode = "n";
          key = "<leader>gs";
          action.__raw = "vim.lsp.buf.signature_help";
          options.desc = "(lsp) Show signature help";
        }
        {
          mode = "n";
          key = "<leader>gr";
          action = "<cmd>Telescope lsp_references<CR>";
          options.desc = "(telescope, lsp) Show LSP references";
        }
        {
          mode = "n";
          key = "<leader>gd";
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
          key = "<leader>ds";
          action.__raw = "vim.diagnostic.open_float";
          options.desc = "(diagnostic) Show diagnostic float";
        }
        {
          mode = "n";
          key = "<leader>do";
          action.__raw = "vim.diagnostic.setloclist";
          options.desc = "(diagnostic) Open diagnostics list";
        }
        {
          mode = "n";
          key = "<leader>ti";
          action.__raw = ''
            function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end
          '';
          options.desc = "(lsp) Toggle inlay hints";
        }
      ];
    };
  };
}
