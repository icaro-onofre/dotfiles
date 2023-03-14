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
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'rktjmp/lush.nvim' 
  use('neovim/nvim-lspconfig')
  use('jose-elias-alvarez/null-ls.nvim')
  -- Here is the formatting config
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
  
  use('muniftanjim/prettier.nvim')
  use {
    'nvim-treesitter/nvim-treesitter',
     run = ':tsupdate'
  }
  require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- do not enable for files with more than n lines, int
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
  use { 'bfredl/nvim-ipy'}
  use { "catppuccin/nvim", as = "catppuccin" }
  use  'nvim-tree/nvim-tree.lua' 
  use {"xuyuanp/nerdtree-git-plugin"}
  use {"philrunninger/nerdtree-visual-selection"}
  use "tpope/vim-surround"
  use "ziontee113/color-picker.nvim"
  use "tpope/vim-fugitive"
  use "mattn/emmet-vim"
  use "neovim/nvim-lspconfig"
  use "kabouzeid/nvim-lspinstall"
  use 'rafamadriz/friendly-snippets'
  use 'ryanoasis/vim-devicons'
  use 'norcalli/nvim-colorizer.lua'

  use { 'mrshmllow/document-color.nvim', config = function()
  require("document-color").setup {
    -- default options
    mode = "background", -- "background" | "foreground" | "single"
  }
  end
  }

  local snippets_folder = vim.fn.stdpath "config" .. "/lua/config/snip/snippets/"
  require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
  vim.cmd [[command! luasnipedit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

  use({

  "l3mon4d3/luasnip",
  tag = "v1.*",
  config = function()


    local ls = require("luasnip")

    -- for "all" filetypes create snippet for "func"
    ls.add_snippets( "all", {
      ls.parser.parse_snippet(
        'func',
        'function ${1}(${2}) \n{\n\t${3}\n}'),
    })

    -- map "ctrl + p" (in insert mode)
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

  if packer_bootstrap then
    require('packer').sync()
  end
end)

