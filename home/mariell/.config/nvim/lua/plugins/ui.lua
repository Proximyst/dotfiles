return {
  --  {
  --    'sainnhe/gruvbox-material',
  --    lazy = false,
  --    priority = 5000,
  --    config = function()
  --      vim.opt.termguicolors = true
  --      vim.opt.background = 'dark'
  --      vim.g.gruvbox_material_background = 'soft'
  --      vim.g.gruvbox_material_foreground = 'material' -- material, mix, or original; i wanna try the new stuff.
  --      vim.g.gruvbox_material_better_performance = true
  --      vim.cmd [[colorscheme gruvbox-material]]
  --    end,
  --  },
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 5000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = 'dark'
      vim.cmd [[colorscheme catppuccin-macchiato]]
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
      enable = true,
      max_lines = 5,
      min_window_height = 10,
      line_numbers = true,
      trim_scope = 'outer',
    },
  },
  'machakann/vim-highlightedyank',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    opts = {
      options = {
        -- theme = 'gruvbox-material',
        theme = 'catppuccin-macchiato',
        component_separators = { left = '|', right = '|' },
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,     -- use a classic bottom cmdline for search
        command_palette = true,   -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,       -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,   -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
}
