{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          python = [ "ruff_format" ];
          nix = [ "nixfmt" ];
        };

        format_on_save = {
          __raw = ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return { timeout_ms = 2000, lsp_format = "fallback" }
            end
          '';
        };
      };
    };

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>cf";
        action.__raw = ''
          function()
            require("conform").format({ lsp_format = "fallback" })
          end
        '';
        options.desc = "(conform) Format buffer";
      }
    ];

    extraConfigLua = ''
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, { desc = "Disable format-on-save", bang = true })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Re-enable format-on-save" })
    '';

    extraPackages = with pkgs; [
      ruff
      nixfmt-rfc-style
    ];
  };
}
