vim.o.termguicolors = true

require 'colorizer'.setup()

vim.cmd('colorscheme tokyonight-night')

vim.cmd('set rnu')

vim.g.mapleader=' '
vim.opt.number = true
vim.opt.swapfile = false

local builtin = require('telescope.builtin')
--General purpose keybindings
vim.keymap.set('n', '<leader>rr', ":checktime <CR>")
vim.keymap.set('n', '<leader>rb', ":source % <CR>")
--Telescope keybindings
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- Code running
vim.keymap.set('n','<leader>rp',':!python %<CR>')
-- Gitsigns keybindings
vim.keymap.set('n','<leader>gs',':Gitsigns stage_hunk<CR>')
vim.keymap.set('n','<leader>gu',':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n','<leader>gb',':Gitsigns stage_buffer<CR>')
vim.keymap.set('n','<leader>gj',':Gitsigns next_hunk<CR>')
vim.keymap.set('n','<leader>gk',':Gitsigns prev_hunk<CR>')
-- Vim fugitive
vim.keymap.set('n','<leader>gg',':Git<CR>')
vim.keymap.set('n','<leader>gc',':Git commit -m "')
-- NERDTree
vim.keymap.set('n','<leader>e',':NvimTreeToggle<CR>')
-- diffview
vim.keymap.set('n','<leader>gd',':DiffviewOpen<CR>')
vim.keymap.set('n','<leader>gq',':DiffviewClose<CR>')

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
  use 'rcarriga/nvim-dap-ui'
  use 'p00f/nvim-ts-rainbow'
  use 'VonHeikemen/lsp-zero.nvim'
  require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
  use 'rktjmp/lush.nvim' 

  use('jose-elias-alvarez/null-ls.nvim') 
  -- Formatting configuration
  local null_ls = require("null-ls")
  local lSsources = {
	  null_ls.builtins.formatting.prettier.with({
		filetypes = {
			  "javascript","typescript","css","scss","html","json","yaml","markdown","graphql","md","txt",
		  },
	  }),
	  null_ls.builtins.formatting.stylua,
  }
  null_ls.setup({
	  sources = lSsources,
  })
  vim.cmd("autocmd BufWritePost * lua vim.lsp.buf.formatting_seq_sync()")
  -- Null LS end configuration
  use('MunifTanjim/prettier.nvim')
  use {
    'nvim-treesitter/nvim-treesitter',
     run = ':TSUpdate'
  }
  require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
   }
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
  use { 'bfredl/nvim-ipy'}
  use { "catppuccin/nvim", as = "catppuccin" }
  use  'nvim-tree/nvim-tree.lua' 
  -- examples for your init.lua

  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  
  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true
  
  -- empty setup using defaults
  require("nvim-tree").setup()
  
  -- OR setup with some options
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })
  use 'nvim-tree/nvim-web-devicons'
  use {"PhilRunninger/nerdtree-visual-selection"}
  use "tpope/vim-surround"
  use "ziontee113/color-picker.nvim"
  use "tpope/vim-fugitive"
  use "mattn/emmet-vim"
  use 'rafamadriz/friendly-snippets'
  use 'ryanoasis/vim-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional
  
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }

  local lsp = require('lsp-zero')

  lsp.ensure_installed({
	  'tsserver'
  })

  lsp.preset('recommended')
  lsp.setup()

  use { 'mrshmllow/document-color.nvim', config = function()
  require("document-color").setup {
    -- Default options
    mode = "background", -- "background" | "foreground" | "single"
  }
  end
  }

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

