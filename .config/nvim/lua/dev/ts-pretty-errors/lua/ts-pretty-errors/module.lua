local function on_tsserver_attach(client)
  if client.name == "tsserver" then
    client.handlers["textDocument/publishDiagnostics"] = function(_, result, context, config)
      local bufnr = context.bufnr

      if result and result.diagnostics then
        for _, diagnostic in ipairs(result.diagnostics) do
          -- Use your translate function on each diagnostic message
          diagnostic.message =
            require("ts-pretty-errors.better-messages").translate(diagnostic.message, diagnostic.code)
        end
      end

      -- Call the default handler
      vim.lsp.diagnostic.on_publish_diagnostics(_, result, context, config)
    end
  end
end

-- Create an autocommand group for the plugin
local group = vim.api.nvim_create_augroup("PrettyPrintErrors", { clear = true })

-- Set up the LspAttach autocommand
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_tsserver_attach(client)
  end,
})
