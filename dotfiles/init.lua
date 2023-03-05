vim.cmd('colorscheme tokyonight-night')
vim.cmd('set rnu')

vim.g.mapleader=' '
vim.opt.number = true
vim.opt.swapfile = false
vim.o.termguicolors = true

vim.bo.tabstop = 4

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- Code running
vim.keymap.set('n','<leader>rp',':!python %<CR>')
-- Gitsigns keybindings
vim.keymap.set('n','<leader>gs',':Gitsigns stage_hunk<CR>')
vim.keymap.set('n','<leader>gb',':Gitsigns stage_buffer<CR>')
vim.keymap.set('n','<leader>gj',':Gitsigns next_hunk<CR>')
vim.keymap.set('n','<leader>gl',':Gitsigns prev_hunk<CR>')
-- Vim fugitive
vim.keymap.set('n','<leader>gg',':Git<CR>')
-- NERDTree
vim.keymap.set('n','<leader>e',':NERDTree<CR>')
-- diffview
vim.keymap.set('n','<leader>gd',':DiffviewOpen<CR>')
vim.keymap.set('n','<leader>gc',':DiffviewClose<CR>')


-- Coc configuration 
vim.api.nvim_set_keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true, replace_keycodes = false})
vim.api.nvim_set_keymap("i", "<C-l>", "coc_snippets_expand",{})

--Packages
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { {'nvim-lua/plenary.nvim'} } }
  use 'honza/vim-snippets'
  use 'mfussenegger/nvim-dap'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'rktjmp/lush.nvim' 
  use {
    'nvim-treesitter/nvim-treesitter',
     run = ':TSUpdate'
  }
  use {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
  end
  }
  use { 'uloco/bluloco.nvim', requires = { 'rktjmp/lush.nvim' } }
  use 'folke/tokyonight.nvim'
  use { 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } }
  use { 'chentoast/marks.nvim'}
  use { 'bfredl/nvim-ipy'}
  use { "catppuccin/nvim", as = "catppuccin" }
  use {"preservim/nerdtree"}
  use {"Xuyuanp/nerdtree-git-plugin"}
  use {"ryanoasis/vim-devicons"}
  use {"PhilRunninger/nerdtree-visual-selection"}
  use "tpope/vim-surround"
  use "ziontee113/color-picker.nvim"
  use "tpope/vim-fugitive"
  use "mattn/emmet-vim"
  use "neovim/nvim-lspconfig"
  use "kabouzeid/nvim-lspinstall"
  use 'rafamadriz/friendly-snippets'
  use 'ryanoasis/vim-devicons'

  local snippets_folder = vim.fn.stdpath "config" .. "/lua/config/snip/snippets/"
  require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
  vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

  use({

  "L3MON4D3/LuaSnip",
  tag = "v1.*",
  config = function()


    local ls = require("luasnip")

    -- for "all" filetypes create snippet for "func"
    ls.add_snippets( "all", {
      ls.parser.parse_snippet(
        'func',
        'function ${1}(${2}) \n{\n\t${3}\n}'),
    })

    -- Map "Ctrl + p" (in insert mode)
    -- to expand snippet and jump through fields.
    vim.keymap.set(
    'i',
    '<c-p>',
    function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end
    )
	require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets" } })
  end
})
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


-- Gitsigns keybindings

