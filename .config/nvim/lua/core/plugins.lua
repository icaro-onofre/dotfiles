local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'
	use {
	    "williamboman/mason.nvim",
	    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { { 'nvim-lua/plenary.nvim' } } }
	use({
	    "kylechui/nvim-surround",
	    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
	    config = function()
		require("nvim-surround").setup({
		    -- Configuration here, or leave empty to use defaults
		})
	    end
	})
	use'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use {'mfussenegger/nvim-dap-python'}
	use'theHamsta/nvim-dap-virtual-text'
	use'Pocco81/DAPInstall.nvim'
	use'nvim-telescope/telescope-dap.nvim'
	use {
	  "microsoft/vscode-js-debug",
	  opt = true,
	  run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" ,
	}

	use 'windwp/nvim-ts-autotag'
	use 'nvim-neotest/neotest'

	use 'p00f/nvim-ts-rainbow'
	use 'rktjmp/lush.nvim'

	use('jose-elias-alvarez/null-ls.nvim')
	use('MunifTanjim/prettier.nvim')
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
	use { 'chentoast/marks.nvim' }
	use { 'bfredl/nvim-ipy' }
	use { "catppuccin/nvim", as = "catppuccin" }
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'
	use { "PhilRunninger/nerdtree-visual-selection" }
	use "ziontee113/color-picker.nvim"
	use "tpope/vim-fugitive"
	use "mattn/emmet-vim"
	use 'rafamadriz/friendly-snippets'
	use 'honza/vim-snippets'
	use 'ryanoasis/vim-devicons'
	use 'norcalli/nvim-colorizer.lua'
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{ -- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'dcampos/nvim-snippy' }, -- Required
		}
	}

	use { 'mrshmllow/document-color.nvim', config = function()
		require("document-color").setup {
			-- Default options
			mode = "background", -- "background" | "foreground" | "single"
		}
	end
	}


	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

	if packer_bootstrap then
		require('packer').sync()
	end
end)
