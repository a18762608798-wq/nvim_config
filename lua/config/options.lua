-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua, in the fact, it will be loaded automatically.
-- Add any additional options here

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 防止 <Space> 在 leader 失效时退回到 normal 模式的“向右移动”
vim.keymap.set({ "n", "x" }, "<Space>", "<Nop>", {
  silent = true,
  desc = "Leader",
})
-- Indentation style
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- Root folder
vim.g.root_spec = { "cwd" }
