local Util = require("util")

return {
  { "nvim-lua/plenary.nvim" },
  {
    "folke/persistence.nvim",
    event = "RootLoaded",
    opts = {},
    config = function(_, opts)
      local persistance = require("persistence")
      persistance.setup(opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.g.starting_root == vim.fn.getcwd() then
            persistance.start()
          else
            persistance.stop()
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Load Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Load Last Session",
      },
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      output = { open_on_run = true, enter = true },
      status = { virtual_text = true },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup(opts)
    end,
  -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },

  { "mvllow/stand.nvim", opts = { minute_interval = 15 } },
  {
    "winter-again/wezterm-config.nvim",
    config = function()
      local wez = require("wezterm-config")
      wez.setup({
        append_wezterm_to_rtp = false,
      })

      -- make wezterm transparent
      -- wez.set_wezterm_user_var("window_background_opacity", 0.9)
      -- wez.set_wezterm_user_var("macos_window_background_blur", 60)

      vim.api.nvim_create_augroup("wezterm", { clear = true })
      vim.api.nvim_create_autocmd("VimLeave", {
        callback = function()
          wez.set_wezterm_user_var("window_background_opacity", 100)
          wez.set_wezterm_user_var("macos_window_background_blur", 0)
        end,
      })
    end,
    lazy = false,
  },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {},
  -- },
}
