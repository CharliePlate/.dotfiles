local Lang = require("util.lang")

return Lang.makeSpec({
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
  Lang.addFormatter({ json = { { "prettierd" } } }),
  Lang.addTreesitterFiletypes({
    "json",
    "json5",
    "jsonc",
  }),
  Lang.addLspServer("jsonls"),
})
