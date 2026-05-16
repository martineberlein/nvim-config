-- Python tooling: pyright (LSP/autocomplete), ruff (lint + format)

-- Ensure tools are installed via Mason
require('mason-tool-installer').setup {
  ensure_installed = { 'pyright', 'ruff' },
  auto_update = true,
  run_on_start = true,
}

-- Pyright: type checking + autocomplete (ruff handles style/lint rules)
vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'basic',
        diagnosticSeverityOverrides = {
          reportUnusedVariable = 'none', -- ruff F841
          reportUnusedImport = 'none', -- ruff F401
          reportMissingImports = 'none', -- ruff F401
          reportUndefinedVariable = 'none', -- ruff F821
        },
      },
    },
  },
})
vim.lsp.enable 'pyright'

-- Ruff LSP: diagnostics, code actions (fixAll, organizeImports), no hover
vim.lsp.config('ruff', {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
})
vim.lsp.enable 'ruff'

-- Ruff as formatter via conform (format-on-save for Python)
local conform = require 'conform'
conform.setup {
  formatters_by_ft = { python = { 'ruff_format' } },
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == 'python' then
      return { timeout_ms = 500 }
    end
  end,
}
