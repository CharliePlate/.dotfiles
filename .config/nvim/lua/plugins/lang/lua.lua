local Lang = require("util.lang")

return Lang.makeSpec({
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neodev.nvim",
        opts = {
          lspconfig = {
            handlers = {
              ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                severity_sort = true,
                underline = true,
                update_in_insert = false,
                virtual_text = { prefix = " 🞶" },
              }),
            },
          },
        },
      },
    },
  },
  Lang.addLspServer("lua_ls"),
  Lang.addFormatter({ lua = { { "stylua" } } }),
  Lang.addTreesitterFiletypes({ "lua" }),
})
