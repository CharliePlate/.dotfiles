local Lang = require("util.lang")

return Lang.makeSpec({
  Lang.addLspServer("pyright"),
  Lang.addFormatter({ python = { "black" } }),
})
