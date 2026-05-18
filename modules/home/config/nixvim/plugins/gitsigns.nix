{ ... }:

{
  programs.nixvim.plugins.gitsigns = {
    enable = true;

    settings.on_attach = { __raw = ''
      function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "<leader>h>",    gs.next_hunk,               "(gitsigns) Next Hunk")
        map("n", "<leader>h<lt>", gs.prev_hunk,               "(gitsigns) Previous Hunk")
        map("n", "<leader>hs",    gs.stage_hunk,              "(gitsigns) Stage hunk")
        map("n", "<leader>hr",    gs.reset_hunk,              "(gitsigns) Reset hunk")
        map("v", "<leader>hs",    function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,                                                   "(gitsigns) Stage hunk")
        map("v", "<leader>hr",    function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,                                                   "(gitsigns) Reset hunk")
        map("n", "<leader>hS",    gs.stage_buffer,            "(gitsigns) Stage buffer")
        map("n", "<leader>hR",    gs.reset_buffer,            "(gitsigns) Reset buffer")
        map("n", "<leader>hu",    gs.undo_stage_hunk,         "(gitsigns) Undo stage hunk")
        map("n", "<leader>hp",    gs.preview_hunk,            "(gitsigns) Preview hunk")
        map("n", "<leader>hb",    function()
          gs.blame_line({ full = true })
        end,                                                   "(gitsigns) Blame line")
        map("n", "<leader>hB",    gs.toggle_current_line_blame,"(gitsigns) Toggle line blame")
        map("n", "<leader>hd",    gs.diffthis,                "(gitsigns) Diff this")
        map("n", "<leader>hD",    function() gs.diffthis("~") end, "(gitsigns) Diff this ~")
      end
    ''; };
  };
}
