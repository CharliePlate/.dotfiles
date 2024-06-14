local Lang = require("util.lang")
local fn = require("util.fn")

return Lang.makeSpec({
  Lang.addFormatter({ rust = { { "rustfmt" } } }, false),
  Lang.addTreesitterFiletypes({ "rust", "ron", "toml" }),
  Lang.addLspServer("rust_analyzer", true),
  Lang.addLspServer("taplo"),
  Lang.addDap("codelldb"),
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = function()
          return {
            -- src = {
            --   cmp = { enabled = true },
            -- },
            popup = {
              border = "rounded",
            },
          }
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "crates" },
      }))
    end,
  },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   lazy = true,
  --   opts = function()
  --     local ok, mason_registry = pcall(require, "mason-registry")
  --     local adapter ---@type any
  --     if ok then
  --       -- rust tools configuration for debugging support
  --       local codelldb = mason_registry.get_package("codelldb")
  --       local extension_path = codelldb:get_install_path() .. "/extension/"
  --       local codelldb_path = extension_path .. "adapter/codelldb"
  --       local liblldb_path = ""
  --       liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
  --       adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  --     end
  --     return {
  --       dap = {
  --         adapter = adapter,
  --       },
  --       tools = {
  --         inlay_hints = {
  --           auto = false,
  --         },
  --         on_initialized = function()
  --           vim.cmd([[
  --               augroup RustLSP
  --                 autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
  --                 autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
  --                 autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
  --               augroup END
  --             ]])
  --         end,
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     local rt = require("rust-tools")
  --     rt.setup(opts)
  --   end,
  -- },
})
