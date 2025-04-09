vim.diagnostic.config({
  virtual_text = true,
  -- Stop diagnostics from taking over focus.
  float = { focusable = false }
})

local has_words_before = function()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local servers = {
  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
        },
      },
    },
  },
  -- Rust
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        imports = {
          prefix = 'self',
        },
        cargo = {
          buildScripts = { enable = true },
          features = 'all',
        },
        procMacro = { enable = true },
        workspace = {
          symbol = {
            search = {
              kind = 'all_symbols',
              scope = 'workspace_and_dependencies',
            },
          },
        },
      },
    },
  },
  -- JSON, JSON5
  jsonls = {},
  -- Shell, bash
  bashls = {},
  -- C, C++
  clangd = {},
  -- Dockerfile / docker-compose
  dockerls = {},
  -- Python
  basedpyright = {},
  -- TOML
  taplo = {},
  -- Golang
  gopls = {},
  -- Elixir
  elixirls = {},
  -- Nix LS
  -- nil_ls = {},
  -- Haskell LSP
  --  hls = {
  --    filetypes = { 'haskell', 'lhaskell', 'cabal' },
  --  },
  -- Jsonnet
  jsonnet_ls = {},
  -- Typescript
  ts_ls = {},
  -- Zig
  zls = {},
}

return {

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(client, bufnr)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { silent = true, buffer = bufnr })
        vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, { silent = true, buffer = bufnr })
        vim.keymap.set('n', '<Leader>ac', vim.lsp.buf.code_action, { silent = true, buffer = bufnr })
        vim.keymap.set('n', '<Leader>dj', function() vim.diagnostic.jump{count=1, float=true} end, { silent = true, buffer = bufnr })
        vim.keymap.set('n', '<Leader>dk', function() vim.diagnostic.jump{count=-1, float=true} end, { silent = true, buffer = bufnr })
        vim.keymap.set('n', '<Leader>dK', vim.diagnostic.open_float, { silent = true, buffer = bufnr })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, buffer = bufnr })

        local augroup_id = vim.api.nvim_create_augroup('CustomLspOnAttach', { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup_id })
--        vim.api.nvim_create_autocmd('CursorHoldI', {
--          buffer = bufnr,
--          callback = function()
--            if client.server_capabilities.signatureHelpProvider then
--              vim.lsp.buf.signature_help()
--            end
--          end
--        })
      end)

      lsp_zero.setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        opts = {
          registries = {
            'lua:mason-registry.index',
            'github:mason-org/mason-registry',
          },
        },
        config = function(_, opts)
          require('mason').setup(opts)
          require('mason-registry').refresh()
        end,
      },
    },
  },

  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_snipmate').lazy_load()
        require('luasnip.loaders.from_lua').lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
      region_check_events = 'CursorMoved',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    version = false, -- they have 1 release, and then just stopped it...
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },
      { 'saadparwaiz1/cmp_luasnip' },
      'neovim/nvim-lspconfig',
    },
    opts = function()
      local lsp_zero = require('lsp-zero')
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      return {
        preselect = cmp.PreselectMode.None,
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping.complete { select = true },
          ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ['<CR>'] = cmp.mapping.confirm { select = false },
        }),
        formatting = lsp_zero.cmp_format(),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp_signature_help', priority = 1250 },
          { name = 'nvim_lsp',                priority = 1000 },
          { name = 'luasnip',                 priority = 750 },
          { name = 'buffer',                  priority = 500 },
          { name = 'nvim_lua',                priority = 250 },
          { name = 'path',                    priority = 100 },
        }),
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'InsertEnter', 'BufNewFile', 'BufReadPost' },
    config = function()
      local servers_keys = {}
      for k, _ in pairs(servers) do
        table.insert(servers_keys, k)
      end

      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      require('mason-lspconfig').setup {
        ensure_installed = servers_keys,
        handlers = {
          lsp_zero.default_setup,
        },
      }

      local lsp = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      for server, server_params in pairs(servers) do
        local params = {
          handlers = {
            ['textDocument/publishDiagnostics'] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics, {
                signs = false,
                virtual_text = false,
                underline = true,
              }
            ),
--            ['textDocument/signatureHelp'] = function ()
--              -- do nada
--            end,
            --['textDocument/signatureHelp'] = vim.lsp.with(
            --  vim.lsp.handlers.signature_help, {
            --    silent = true,
            --    focusable = false,
            --  }
            --),
          },
          capabilities = capabilities,
        }
        local effective_params = vim.tbl_deep_extend('force', params, server_params)
        lsp[server].setup(effective_params)
      end
    end,
  },
}
