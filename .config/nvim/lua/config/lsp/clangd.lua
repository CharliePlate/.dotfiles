return {
  -- remove proto from th8is array
  filetypes = vim.tbl_filter(function(val)
    return val ~= "proto"
  end, require("lspconfig").clangd.document_config.default_config.filetypes),
}
