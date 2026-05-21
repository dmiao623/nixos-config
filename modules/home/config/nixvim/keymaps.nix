{ ... }:

{
  programs.nixvim = {
    keymaps = [
      # Replace default bindings
      {
        mode = "n";
        key = "x";
        action = ''"_x'';
      }
      {
        mode = "n";
        key = "c";
        action = ''"_c'';
      }
      {
        mode = "x";
        key = "V";
        action = "j";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = ":nohl<CR>:echo<CR>";
        options.silent = true;
      }

      # Splits
      {
        mode = "n";
        key = "<leader>sv";
        action = "<cmd>vsplit<CR>";
        options.desc = "Create vertical split";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>split<CR>";
        options.desc = "Create horizontal split";
      }
      {
        mode = "n";
        key = "<leader>se";
        action = "<C-w>=";
        options.desc = "Equalize splits";
      }
      {
        mode = "n";
        key = "<leader>sx";
        action = "<cmd>close<CR>";
        options.desc = "Close current split";
      }

      # Oil file explorer
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<CR>";
        options.desc = "(oil) Opens file explorer";
      }

      # Toggles (invoke user commands defined in extraLuaConfig below)
      {
        mode = "n";
        key = "<leader>tw";
        action = "<cmd>WrapToggle<CR>";
        options.desc = "Toggle wrap";
      }
    ];

    extraConfigLua = ''
      -- Smart dd: don't yank empty lines
      vim.keymap.set("n", "dd", function()
        if vim.fn.getline(".") == "" then return '"_dd' end
        return "dd"
      end, { expr = true })

      -- Yank without moving cursor
      local cursorPreYank
      vim.keymap.set({ "n", "x" }, "y", function()
        cursorPreYank = vim.api.nvim_win_get_cursor(0)
        return "y"
      end, { expr = true })
      vim.keymap.set("n", "Y", function()
        cursorPreYank = vim.api.nvim_win_get_cursor(0)
        return "y$"
      end, { expr = true })
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          if vim.v.event.operator == "y" and cursorPreYank then
            vim.api.nvim_win_set_cursor(0, cursorPreYank)
          end
        end,
      })

      -- User commands
      local wrapToggle = false
      vim.api.nvim_create_user_command("WrapToggle", function()
        wrapToggle = not wrapToggle
        vim.wo.wrap = wrapToggle
        vim.wo.linebreak = wrapToggle
        vim.wo.breakindent = wrapToggle
        if wrapToggle then
          vim.wo.breakindentopt = "shift:2,min:40,sbr"
          vim.wo.showbreak = "+\\"
        else
          vim.wo.breakindentopt = ""
          vim.wo.showbreak = ""
        end
        local opts = { noremap = true, silent = true }
        for _, mode in ipairs({ "n", "v", "x" }) do
          if wrapToggle then
            vim.keymap.set(mode, "j", "gj", opts)
            vim.keymap.set(mode, "k", "gk", opts)
            vim.keymap.set(mode, "$", "g$", opts)
            vim.keymap.set(mode, "0", "g0", opts)
          else
            vim.keymap.set(mode, "j", "j", opts)
            vim.keymap.set(mode, "k", "k", opts)
            vim.keymap.set(mode, "$", "$", opts)
            vim.keymap.set(mode, "0", "0", opts)
          end
        end
        print(wrapToggle and "wrap enabled" or "wrap disabled")
      end, { desc = "toggle wrap" })

      vim.api.nvim_create_user_command("CountChars", function()
        vim.cmd(":%s/./&/gn")
      end, { desc = "count characters" })

      vim.api.nvim_create_user_command("CountWords", function()
        vim.cmd(":%s/\\i\\+/&/gn")
      end, { desc = "count words" })
    '';
  };
}
