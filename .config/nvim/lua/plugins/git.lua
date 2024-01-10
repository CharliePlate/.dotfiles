return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      yadm = {
        enable = true,
      },
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local Keys = require("util.keys")
        ---@type LazyKeysSpec[]
        -- stylua: ignore
        local maps = {
          { "]h", gs.next_hunk, buffer = buffer, desc = "Next Hunk" },
          { "[h", gs.prev_hunk, buffer = buffer, desc = "Prev Hunk" },
          { "<leader>gs", ":Gitsigns stage_hunk<CR>", buffer = buffer, desc = "Stage Hunk" },
          { "<leader>gs", ":Gitsigns stage_hunk<CR>", mode = "v", buffer = buffer, desc = "Stage Hunk" },
          { "<leader>gr", ":Gitsigns reset_hunk<CR>", buffer = buffer, desc = "Reset Hunk" },
          { "<leader>gr", ":Gitsigns reset_hunk<CR>", mode = "v", buffer = buffer, desc = "Reset Hunk" },
          { "<leader>gu", gs.undo_stage_hunk, buffer = buffer, desc = "Undo Stage Hunk" },
          { "<leader>gp", gs.preview_hunk, buffer = buffer, desc = "Preview Hunk" },
          { "<leader>gl", function() gs.blame_line({ full = true }) end, buffer = buffer, desc = "Blame Line" },
          { "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = "x", buffer = buffer, desc = "GitSigns Select Hunk" },
          { "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = "o", buffer = buffer, desc = "GitSigns Select Hunk" },
        }

        Keys.addAndSet(maps)
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
  },
}
