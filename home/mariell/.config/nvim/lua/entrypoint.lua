-- vim: set ff=unix autoindent ts=2 sw=2 tw=0 et :

-- All <Leader> mappings should start with a space.
vim.g.mapleader = ' '
vim.keymap.set('n', '<Leader>w', '<CMD>w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>j', '<C-W>j', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>h', '<C-W>h', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>k', '<C-W>k', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>l', '<C-W>l', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>H', '<CMD>noh<CR>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<Leader>s', '"+', { noremap = true, silent = true })
vim.keymap.set('n', '<Esc>', function()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    pcall(function()
      if vim.api.nvim_win_get_config(winid).relative ~= '' then
        -- This is a floating window.
        vim.api.nvim_win_close(winid, true)
      end
    end)
  end
end, { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
-- Disable NBSPs
vim.keymap.set('i', '\\u00A0', '<Space>', { noremap = true, silent = true })

-- Have coloured columns at col 80, 120, ...
vim.wo.colorcolumn = '80,120,140,240'
-- ... and have it be lightgrey, cause bright red is ugly.
vim.cmd [[highlight ColorColumn ctermbg=0 guibg=lightgrey]]
-- Display relative numbers on the side.
vim.opt.number = true
vim.opt.relativenumber = true
-- When closing buffers with unsaved modifications, hide it instead of dropping.
vim.opt.hidden = true
-- When using commands, allow for completions.
vim.opt.wildmenu = true
-- Highlight the entire line the cursor is currently on.
vim.opt.cursorline = true
-- When typing searches, show the matches as they're being typed.
vim.opt.incsearch = true
-- Highlight all the previous search matches. Clear with :noh / <Leader>H.
vim.opt.hlsearch = true
-- Override the ignorecase option if the search includes uppercase characters.
-- This means searching for "abc" will find both "abc" and "Abc", but searching
--   for "Abc" will not find "abc" or "ABC", but find "Abc".
vim.opt.smartcase = true
-- Allow to backspace anywhere in vim.
vim.opt.backspace = 'indent,eol,start'
-- Disable the vim-builtin info at the bottom of the screen; we use a status
--   line plugin.
vim.opt.ruler = false
vim.opt.showmode = false
-- Make commands not move to the start of line unless 0 is pressed.
vim.opt.startofline = false
-- Certain commands need confirmation; use a dialog for them.
vim.opt.confirm = true
-- Mouse support for normal, visual, insert, command-line, and help mode.
vim.opt.mouse = 'a'
-- Indent smartly when starting a new line.
vim.opt.smartindent = true
-- Disable the stupid beep. Use a visual bell instead.
vim.opt.visualbell = true
-- Make the command input only 1 line tall.
vim.opt.cmdheight = 1
-- Don't make backup files before overwriting files; this is why we have Git.
vim.opt.backup = false
vim.opt.writebackup = false
-- Timeout any unfinished keypresses after 500ms.
vim.opt.timeoutlen = 500
-- ... but don't have timeouts at all for keypresses.
vim.opt.ttimeoutlen = 10
-- Always show the status line.
vim.opt.laststatus = 2
-- Don't show me ins-completion-menu messages.
vim.opt.shortmess:append('c')
-- Use 24-bit colours.
vim.opt.termguicolors = true
-- After 300 milliseconds of inactivity, update the swap file.
vim.opt.updatetime = 300
-- :split should go below, and :vsplit should go to the right of the current
--   buffer.
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Always show text normally.
vim.opt.conceallevel = 0
vim.opt.concealcursor = ''
-- When doing folds, prefer the {{{ }}} markers.
vim.opt.foldmethod = 'marker'
-- Don't expand TAB into spaces.
vim.opt.expandtab = false
-- Each TAB should be 4 spaces long.
vim.opt.tabstop = 4
-- ... and each soft tab should be 0 spaces long, to show something is broken.
vim.opt.softtabstop = 0
-- Shifting should be 4 spaces long.
vim.opt.shiftwidth = 4

-- Add commands for :Spaces <n> and :Tabs <n> to set the vim mode for what the
--   file uses.
vim.api.nvim_create_user_command('Spaces', function(opts)
  local num = tonumber(opts.fargs[1])
  if num == nil then
    print('error: got a non-number: ' .. opts.fargs[1])
    return
  end
  vim.bo.tabstop = num
  vim.bo.shiftwidth = num
  vim.bo.softtabstop = num
  vim.bo.expandtab = true
end, { nargs = 1, desc = 'Sets the indent size of Spaces for the buffer.' })
vim.api.nvim_create_user_command('Tabs', function(opts)
  local num = tonumber(opts.fargs[1])
  if num == nil then
    print('error: got a non-number: ' .. opts.fargs[1])
    return
  end
  vim.bo.tabstop = num
  vim.bo.shiftwidth = num
  vim.bo.softtabstop = num
  vim.bo.expandtab = false
end, { nargs = 1, desc = 'Sets the indent size of Tabs for the buffer.' })

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This will merge all files under `/lua/plugins/` into a spec.
require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
})
