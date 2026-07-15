{ ... }:

{
  programs.nixvim.extraConfigLua = ''
    vim.lsp.inlay_hint.enable(true)

    -- Switch between .cpp/.hpp (clangd) or .ml/.mli (ocamllsp)
    function _G.switch_source_file()
      local bufnr = vim.api.nvim_get_current_buf()
      local ft = vim.bo[bufnr].filetype

      if ft == "ocaml" or ft == "ocaml.interface" or ft == "ocaml.menhir" then
        local client = vim.lsp.get_clients({ bufnr = bufnr, name = "ocamllsp" })[1]
        if not client then
          vim.notify("ocamllsp not attached", vim.log.levels.WARN)
          return
        end
        client:request("ocamllsp/switchImplIntf", { uri = vim.uri_from_bufnr(bufnr) },
          function(err, result)
            if err then
              vim.notify(tostring(err), vim.log.levels.ERROR)
              return
            end
            if result and result[1] then
              vim.cmd.edit(vim.uri_to_fname(result[1]))
            end
          end, bufnr)
      else
        local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
        if not client then
          vim.notify("clangd not attached", vim.log.levels.WARN)
          return
        end
        local params = vim.lsp.util.make_text_document_params(bufnr)
        client:request("textDocument/switchSourceHeader", params,
          function(err, result)
            if err then
              vim.notify(tostring(err), vim.log.levels.ERROR)
              return
            end
            if result then
              vim.cmd.edit(vim.uri_to_fname(result))
            else
              vim.notify("No matching source/header file", vim.log.levels.INFO)
            end
          end, bufnr)
      end
    end
  '';

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
          key = "<leader>k";
          action.__raw = "vim.lsp.buf.signature_help";
          options.desc = "(lsp) Show signature help";
        }
        {
          mode = "n";
          key = "<leader>ss";
          action = "<cmd>lua _G.switch_source_file()<CR>";
          options.desc = "(lsp) Switch .ml/.mli or .cpp/.hpp";
        }
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
