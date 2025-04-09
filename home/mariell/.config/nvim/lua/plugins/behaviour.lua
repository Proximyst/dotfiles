return {
  'tpope/vim-endwise',
  'tpope/vim-sleuth',
  {
    'notjedi/nvim-rooter.lua',
    config = function()
      local r = require('nvim-rooter')
      r.setup {
        manual = true,
      }
      -- Run only once on startup, then leave it be.
      r.rooter_default()
    end,
  },
}
