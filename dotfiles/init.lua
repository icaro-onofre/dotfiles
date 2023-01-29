vim.cmd('colorscheme torte')

vim.g.mapleader=' '
vim.opt.number = true
vim.opt.swapfile = false

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
  use { 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } }
  use { 'chentoast/marks.nvim'}
  use { 'jupyter-vim/jupyter-vim'}


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

