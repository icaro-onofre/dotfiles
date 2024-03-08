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
"nvim-treesitter/nvim-treesitter",
"HiPhish/rainbow-delimiters.nvim",
{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
{'neovim/nvim-lspconfig'},
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},
{'nvim-tree/nvim-web-devicons'},
{
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
},

})

-- Set leader key
vim.g.mapleader = " "
-- Basic UI configurations
vim.opt.termguicolors = true  	
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.cmd 'colorscheme tokyonight-storm' -- select this colorscheme if it is installed
vim.cmd 'set rnu'
-- treesitter configurations
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff',builtin.find_files, {})
vim.keymap.set('n', '<leader>fg',builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb',builtin.buffers, {})
vim.keymap.set('n', '<leader>fh',builtin.help_tags, {})
-- diff view keybindings
--vim.keymap.set('n', '<leader>gd',DiffViewOpen, {})
--vim.keymap.set('n', '<leader>gq',DiffViewClose, {})
-- Set no swap
vim.opt.swapfile = false

--Editor remaps 
-- Move text in visual mode
vim.keymap.set("v","J",":m '>+1<CR>gv=gv")
vim.keymap.set("v","K",":m '<-2<CR>gv=gv")

vim.keymap.set("n","J","mzJ`z")

vim.keymap.set("n","<C-d>","<C-d>zz")
vim.keymap.set("n","<C-u>","<C-u>zz")

vim.keymap.set("n","n","nzzzv")
vim.keymap.set("n","N","Nzzzv")

--vim.keymap.set("x","<leader>p","\"_dp"(
