local Lang = require("util.lang")

return Lang.makeSpec({
  Lang.addFormatter({ vue = { { "prettierd" } } }),
  Lang.addLspServer("volar"),
  Lang.addTreesitterFiletypes({ "vue" }),
})
