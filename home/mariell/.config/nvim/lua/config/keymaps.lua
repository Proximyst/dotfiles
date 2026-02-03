-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader><tab>h", ":tabprevious<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader><tab>l", ":tabnext<CR>", { desc = "Go to next tab" })
