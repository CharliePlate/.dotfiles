local Lang = require("util.lang")

return Lang.makeSpec({
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            { path = "wezterm-types", mods = { "wezterm" } },
            { path = "LazyVim", words = { "LazyVim" } },
            { path = "lazy.nvim", words = { "LazyVim" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
      { "justinsgithub/wezterm-types", lazy = true }, -- optional `wezterm` typings
      { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
          })
        end,
      },
    },
  },
  Lang.addLspServer("lua_ls"),
  Lang.addFormatter({ lua = { { "stylua" } } }),
  Lang.addTreesitterFiletypes({ "lua" }),
})
