local Lang = require("util.lang")

return Lang.makeSpec({
  Lang.addFormatter({ c = { { "clang-format" } }, cpp = { { "clang-format" } } }),
  Lang.addTreesitterFiletypes({ "c", "cpp" }),
  Lang.addLspServer("clangd"),
  Lang.addDap("cpptools"),
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      -- Ensure C/C++ debugger is installed
      "williamboman/mason.nvim",
      optional = true,
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "codelldb" })
        end
      end,
    },
    opts = function()
      local dap = require("dap")
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = require("mason-core.path").concat({
          vim.fn.stdpath("data"),
          "mason",
          "packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
        }),
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
      }

      dap.configurations.c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          MIMode = "lldb",
        },
        {
          name = "Launch file (with arguments)",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          args = function()
            return vim.fn.split(vim.fn.input("Arguments: "), " ")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          MIMode = "lldb",
        },
      }
    end,
  },
})
