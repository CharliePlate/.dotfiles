local Lang = require("util.lang")

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.templ",
  command = 'silent! !PATH="$PATH:$(go env GOPATH)/bin" templ fmt <afile> >/dev/null 2>&1',
  group = vim.api.nvim_create_augroup("TemplFmt", { clear = true }),
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.go",
  command = "set foldlevel=99",
  group = vim.api.nvim_create_augroup("GoFold", { clear = true }),
})

return Lang.makeSpec({
  Lang.addFormatter({ go = { "goimports", "gofumpt" } }),
  Lang.addTreesitterFiletypes({
    "go",
    "gomod",
    "gowork",
    "gosum",
  }),
  Lang.addLspServer("gopls", false),
  Lang.addLspServer("templ"),
  Lang.addLspServer("golangci_lint_ls"),
  Lang.addDap("delve"),
  {
    "leoluz/nvim-dap-go",
    opts = function()
      return {
        dap_configurations = {
          {
            type = "go",
            name = "Debug Package (with arguments)",
            request = "launch",
            program = "${fileDirname}",
            args = function()
              return coroutine.create(function(dap_run_co)
                local args = {}
                vim.ui.input({ prompt = "Args: " }, function(input)
                  args = vim.split(input or "", " ")
                  coroutine.resume(dap_run_co, args)
                end)
              end)
            end,
          },
        },
      }
    end,
  },
  {
    "edolphin-ydf/goimpl.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    ft = { "go" },
    config = function()
      require("telescope").load_extension("goimpl")
    end,
    keys = {
      {
        "<leader>ci",
        function()
          require("telescope").extensions.goimpl.goimpl({})
        end,
        desc = "Go Implementations",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = function(_, opts)
      return {
        adapters = vim.list_extend(opts.adapters or {}, {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            recursive_run = true,
            args = { "-count=1", "-timeout=60s" },
          }),
        }),
      }
    end,
  },
})
