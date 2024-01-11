local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
"folke/which-key.nvim",
{ "folke/neoconf.nvim", cmd = "Neoconf" },
"folke/neodev.nvim",
"sindrets/diffview.nvim",
"folke/tokyonight.nvim",
"nvim-treesitter/nvim-treesitter",
{
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
},

})

-- Set leader key
vim.g.mapleader = "<Space>"
-- Basic UI configurations
vim.opt.termguicolors = true  	
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.cmd 'colorscheme tokyonight-storm' -- select this colorscheme if it is installed
vim.cmd 'set rnu'
-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff',builtin.find_files, {})
vim.keymap.set('n', '<leader>fg',builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb',builtin.buffers, {})
vim.keymap.set('n', '<leader>fh',builtin.help_tags, {})
-- Set no swap
vim.opt.swapfile = false
