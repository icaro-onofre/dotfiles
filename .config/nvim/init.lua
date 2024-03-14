-- Icaro's Neovim conifguration
--
-- Lazy configuration bootstrap and plugins installation.
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
	"tpope/vim-fugitive",
	"chentoast/marks.nvim",
	"nvim-tree/nvim-web-devicons",
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	-- LSP Zero configuration
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},

})

-- NEOVIM Configuration
-- Set leader key
vim.g.mapleader = " "
vim.opt.swapfile = false
-- Basic UI configurations
vim.opt.termguicolors = true  	
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.cmd 'colorscheme tokyonight-storm' -- select this colorscheme if it is installed
vim.cmd 'set rnu'
vim.wo.relativenumber = true
-- treesitter configurations 
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {"c", "lua", "vim", "vimdoc", "query" },
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	-- List of parsers to ignore installing (or "all")
	ignore_install = { "javascript" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
}



-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff',builtin.find_files, {})
vim.keymap.set('n', '<leader>fp',builtin.git_files, {})
vim.keymap.set('n', '<leader>fg',builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb',builtin.buffers, {})
vim.keymap.set('n', '<leader>fh',builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm',builtin.marks, {})

-- DiffView keybindings
vim.keymap.set('n', '<leader>gd','<CMD>DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>gq','<CMD>DiffviewClose <CR>' )


-- PLUGIN marks.nvim setup.
require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}
-- LSP setups 
require('lsp-zero')
require('lspconfig').lua_ls.setup({})

-- Tailwind css
-- Run npm install -g @tailwindcss/language-server
-- require'lspconfig'.tailwindcss.setup{}
-- Typescript 
-- Run npm install -g typescript typescript-language-server
-- add to root of project 
-- {
  -- "compilerOptions": {
    -- "module": "commonjs",
    -- "target": "es6",
    -- "checkJs": false
  -- },
  -- "exclude": [
    -- "node_modules"
  -- ]
-- }
-- require'lspconfig'.tsserver.setup{}
