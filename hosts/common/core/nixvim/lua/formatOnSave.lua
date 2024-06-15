-- To be run on save via conform-nvim
function(bufnr)
  -- Disable with a global or buffer-local variable
  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    return
  end
    return { timeout_ms = 500, lsp_fallback = true }
end
