return {
  -- 1. Setup Mason to handle the binaries
  {
    'williamboman/mason.nvim',
    opts = {},
  },

  -- 2. Automatically install Pyright and Ruff
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = { 'pyright', 'ruff' },
      auto_update = true,
      run_on_start = true,
    },
  },

  -- 3. Configure the LSPs (Modern 0.11 Style)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      -- Grab default capabilities for autocompletion
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_lsp = package.loaded['cmp_nvim_lsp']
      if cmp_lsp then capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities()) end

      -- NEW: The modern way to enable servers
      -- This replaces lspconfig.pyright.setup()
      vim.lsp.config('pyright', {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = 'basic',
            },
          },
        },
      })
      vim.lsp.enable 'pyright'

      vim.lsp.config('ruff', {
        capabilities = capabilities,
        on_attach = function(client, _) client.server_capabilities.hoverProvider = false end,
      })
      vim.lsp.enable 'ruff'

      -- Format-on-Save Autocommand
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.py',
        callback = function()
          vim.lsp.buf.code_action {
            context = { only = { 'source.fixAll' } },
            apply = true,
          }
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },
}
