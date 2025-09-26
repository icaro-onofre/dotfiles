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
"sindrets/diffview.nvim",					 -- Git helper
"lewis6991/gitsigns.nvim",					 -- Git helper

"HiPhish/rainbow-delimiters.nvim",			 -- UI&Icons

"chentoast/marks.nvim",						 -- UI&Icons

'norcalli/nvim-colorizer.lua',				 -- UI&Icons

--LSP Zero block
{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
{'neovim/nvim-lspconfig'},
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},

{'nvim-tree/nvim-web-devicons'}, 			-- UI&Icons

{ 'nvim-telescope/telescope.nvim', tag = '0.1.5', -- Telescope grep fuzzy find.
	dependencies = { 'nvim-lua/plenary.nvim' }, },

-- Debugging with neovim dap
{ 'mfussenegger/nvim-dap' },

-- Text&Code Editing Surround nvim add "" () {} or anything add anything around selected text
-- neovim surround
{
    "kylechui/nvim-surround",
    version = "*", 
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
},
-- Vim multiline
{ 'mg979/vim-visual-multi' },


-- List od DAP(Debug adapter protocol) comment the line out for removing the installed DAP 
{ "mxsdev/nvim-dap-vscode-js" },

})

-- Set leader key
vim.g.mapleader = " "
-- Basic UI configurations
vim.opt.termguicolors = true  	
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.cmd 'colorscheme wildcharm' -- select this colorscheme if it is installed
vim.cmd 'set rnu'
vim.cmd 'set nu'


-- Interface configuration
require'colorizer'.setup()
--
-- gitsigns configuration

require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

-- Keymaps configurations

-- neovim general keybindings
vim.keymap.set('n', '<leader>R',"<Cmd>source %<CR>", {})


-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t',builtin.find_files, {})
vim.keymap.set('n', '<leader>fp',builtin.git_files, {})
vim.keymap.set('n', '<leader>fg',builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb',builtin.buffers, {})
vim.keymap.set('n', '<leader>fh',builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm',builtin.marks, {})
vim.keymap.set('n', '<leader>n',"<Cmd>cn<CR>", {})
vim.keymap.set('n', '<leader>p',"<Cmd>cp<CR>", {})
-- Lsp telescope
vim.keymap.set('n', '<leader>fr',builtin.lsp_references, {})

-- vim.keymap.set('n', '<leader>fc',builtin.telescope.builtin.colorscheme, {})


-- diff view keybindings
vim.keymap.set('n', '<leader>gd',"<Cmd>DiffviewOpen<CR>", {})
vim.keymap.set('n', '<leader>gq',"<Cmd>DiffviewClose<CR>", {})
vim.keymap.set('n', '<leader>gw',"<Cmd>DiffviewFileHistory<CR>", {})
--gitsigns keybidings
vim.keymap.set('n', 'gs',"<Cmd>Gitsigns stage_hunk<CR>", {})
vim.keymap.set('n', 'gu',"<Cmd>Gitsigns undo_stage_hunk<CR>", {})
vim.keymap.set('n', 'gn',"<Cmd>Gitsigns next_hunk<CR>", {})
vim.keymap.set('n', 'gp',"<Cmd>Gitsigns next_hunk<CR>", {})
vim.keymap.set('n', '<leader>G',"<Cmd>Git<CR>", {})
-- vim.keymap.set('n', '<leader>gc',"Git commit ", {})

-- Set no swap
vim.opt.swapfile = false

--Editor remaps
-- Move text in visual mode
-- vim.keymap.set("v","J",":m '>+1<CR>gv=gv")
-- vim.keymap.set("v","K",":m '<-2<CR>gv=gv")
-- vim.keymap.set("n","J","mzJ`z")

vim.keymap.set("n","<C-d>","<C-d>zz")
vim.keymap.set("n","<C-u>","<C-u>zz")

vim.keymap.set("n","n","nzzzv")
vim.keymap.set("n","N","Nzzzv")

vim.keymap.set("n","'","`")

--vim.keymap.set("x","<leader>p","\"_dp"(


-- LSP configs
-- require('lsp-zero').gopls.setup({})
require('lsp-zero')
-- Run yay -S typescript-language-server
-- require('lspconfig').tailwindcss.setup({})
-- Run sudo npm i -g @tailwindcss/language-server
require('lspconfig').tailwindcss.setup({})
-- Run sudo npm -g install --save vscode-html-languageservice
require('lspconfig').ts_ls.setup({})
-- java language server
require'lspconfig'.jdtls.setup{}
-- install jdtls with yay -S jdtls
-- HTML language server 
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

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


-- LSP ZERO keymaps config
-- For a listing of all keymaps available for lsp server do :h default_keymaps
vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.format()<cr>', opts)
vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
vim.keymap.set('n', 'gp', '<cmd>lua vim.lsp.buf.document_symbols()<cr>', opts)


--Begin DAP Configuration

-- configuring individual DAPs
require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/home/fforelle/bin/vscode-js-debug/", -- Path to vscode-js-debug installation.
  adapters = {'pwa-node', 'pwa-chrome'}, 
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})
-- end configuring individual daps

local dap = require('dap')

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
	{
	  {
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	  },
	  {
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		processId = require'dap.utils'.pick_process,
		cwd = "${workspaceFolder}",
	  },
	  {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          }
	}  
}
end

-- DAP keymaps
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

--End DAP Configuration
