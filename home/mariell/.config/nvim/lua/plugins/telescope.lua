return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    version = false,
    keys = {
      { '<Leader><Tab>', '<CMD>Telescope find_files<CR>' },
      { '<Leader>gr',    '<CMD>Telescope live_grep<CR>' },
      { '<Leader>gb',    '<CMD>Telescope buffers<CR>' },
      { '<Leader>gh',    '<CMD>Telescope help_tags<CR>' },
      { '<Leader>gf',    '<CMD>Telescope lsp_references<CR>' },
      { '<Leader>gd',    '<CMD>Telescope lsp_definitions<CR>' },
      { '<Leader>gi',    '<CMD>Telescope lsp_implementations<CR>' },
      { '<Leader>gi',    '<CMD>Telescope lsp_implementations<CR>' },
      { '<Leader>gg',    '<CMD>Telescope resume<CR>' },
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
    },
    opts = function()
      local actions = require('telescope.actions')
      return {
        defaults = {
          sorting_strategy = 'ascending',
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-c>'] = actions.close,
            },
            n = {
              ['<C-c>'] = actions.close,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
        pickers = {
          find_files = {
            follow = true,
          },
        },
      }
    end,
  },
}
