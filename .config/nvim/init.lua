-- =========================================================
-- BOOTSTRAP LAZY.NVIM
-- =========================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- =========================================================
-- PLUGIN SETUP
-- =========================================================
require("lazy").setup({

-- =========================
-- Core Utilities
-- =========================
"folke/which-key.nvim",
{ "folke/neoconf.nvim", cmd = "Neoconf" },
"folke/neodev.nvim",

-- =========================
-- Git
-- =========================
"sindrets/diffview.nvim",
"lewis6991/gitsigns.nvim",

-- =========================
-- UI / Icons / Visual
-- =========================
"HiPhish/rainbow-delimiters.nvim",
"chentoast/marks.nvim",
"norcalli/nvim-colorizer.lua",
"nvim-tree/nvim-web-devicons",

-- =========================
-- Navigation / Motion
-- =========================
{
  "smoka7/hop.nvim",
  version="*",
  opts = {
    keys = 'etovxqpdygfblzhckisuran'
  }
},

{
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<C-s>",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash jump"
    }
  }
},

-- =========================
-- Editing Improvements
-- =========================
{
  "kylechui/nvim-surround",
  version="*",
  event="VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end
},

-- =========================
-- Telescope
-- =========================
{
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
},

-- =========================
-- LSP + Completion
-- =========================
{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
{'neovim/nvim-lspconfig'},
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},

-- =========================
-- Debugging
-- =========================
{ 'mfussenegger/nvim-dap' },
{ "mxsdev/nvim-dap-vscode-js" },

-- =========================
-- Flutter Tools
-- =========================
'nvim-flutter/flutter-tools.nvim',
{
  'nvim-lua/plenary.nvim',
  'stevearc/dressing.nvim'
}

})

-- =========================================================
-- GENERAL NEOVIM SETTINGS
-- =========================================================
vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.swapfile = false

vim.cmd("set nu")
vim.cmd("colorscheme wildcharm")

-- =========================================================
-- PLUGIN CONFIGURATIONS
-- =========================================================

-- Colorizer
require('colorizer').setup()

-- =========================================================
-- GITSIGNS CONFIG
-- =========================================================
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,
  watch_gitdir = { follow_files = true },
  auto_attach = true,
}

-- =========================================================
-- KEYMAPS
-- =========================================================

-- -------- General --------
vim.keymap.set('n', '<leader>R', "<Cmd>source %<CR>")

-- -------- Quickfix --------
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>')

-- -------- Motion --------
vim.keymap.set('n', '<leader>w', '<Cmd>HopWordMW<CR>')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- -------- Telescope --------
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files)
vim.keymap.set('n', '<leader>fp', builtin.git_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<M-b>', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fm', builtin.marks)

-- LSP Telescope
vim.keymap.set('n', '<leader>fr', builtin.lsp_references)
vim.keymap.set('n', '<leader>fo', builtin.lsp_document_symbols)

-- -------- Git --------
vim.keymap.set('n', '<leader>gd', "<Cmd>DiffviewOpen<CR>")
vim.keymap.set('n', '<leader>gq', "<Cmd>DiffviewClose<CR>")
vim.keymap.set('n', '<leader>gw', "<Cmd>DiffviewFileHistory<CR>")

vim.keymap.set('n', 'gs', "<Cmd>Gitsigns stage_hunk<CR>")
vim.keymap.set('n', 'gu', "<Cmd>Gitsigns undo_stage_hunk<CR>")
vim.keymap.set('n', 'gn', "<Cmd>Gitsigns next_hunk<CR>")
vim.keymap.set('n', 'gp', "<Cmd>Gitsigns next_hunk<CR>")

-- -------- Editor behavior --------
vim.keymap.set("n","<C-d>","<C-d>zz")
vim.keymap.set("n","<C-u>","<C-u>zz")
vim.keymap.set("n","n","nzzzv")
vim.keymap.set("n","N","Nzzzv")
vim.keymap.set("n","'","`")

-- =========================================================
-- LSP CONFIGURATION
-- =========================================================
require('lsp-zero')

local lspconfig = require('lspconfig')

-- Language servers
lspconfig.tailwindcss.setup({})
lspconfig.ts_ls.setup({})
lspconfig.jdtls.setup({})
lspconfig.dartls.setup({})
lspconfig.gopls.setup({})

-- HTML LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup {
  capabilities = capabilities
}

-- =========================================================
-- LSP AUTOCOMMANDS
-- =========================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Enable autocompletion
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- Format on save
    if not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting') then

      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 1000 })
        end
      })

    end
  end,
})

-- =========================================================
-- LSP KEYMAPS
-- =========================================================
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
vim.keymap.set('n', '<F3>', vim.lsp.buf.format)
vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action)

vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)

vim.keymap.set('n', 'ga', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'go', vim.lsp.buf.type_definition)

-- =========================================================
-- MARKS.NVIM CONFIG
-- =========================================================
require'marks'.setup {
  default_mappings = true,
  builtin_marks = { ".", "<", ">", "^" },
  cyclic = true,
  refresh_interval = 250,
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },

  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    annotate = false,
  }
}

-- =========================================================
-- DAP (DEBUGGING) CONFIG
-- =========================================================
local dap = require("dap")

-- Chrome debugger
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = {os.getenv("HOME") .. "/bin/vscode-chrome-debug/out/src/chromeDebug.js"}
}

dap.configurations.typescriptreact = {
  {
    type = "chrome",
    request = "attach",
    runtimeExecutable = "google-chrome-stable",
    runtimeArgs = { "--remote-debugging-port=9222" },
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}"
  }
}

-- Flutter / Dart debugging
dap.adapters.dart = {
  type = 'executable',
  command = 'dart',
  args = { 'debug_adapter' },
  options = { detached = false }
}

dap.adapters.flutter = {
  type = 'executable',
  command = 'flutter',
  args = { 'debug_adapter' },
  options = { detached = false }
}

dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch dart",
    dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart",
    flutterSdkPath = "/opt/flutter/bin/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  }
}

-- =========================================================
-- DAP KEYMAPS
-- =========================================================
vim.keymap.set('n','<F5>',function() require('dap').continue() end)
vim.keymap.set('n','<F10>',function() require('dap').step_over() end)
vim.keymap.set('n','<F11>',function() require('dap').step_into() end)
vim.keymap.set('n','<F12>',function() require('dap').step_out() end)
vim.keymap.set('n','<F9>',function() require('dap').toggle_breakpoint() end)

vim.keymap.set('n','<Leader>B',function() require('dap').set_breakpoint() end)
vim.keymap.set('n','<Leader>dr',function() require('dap').repl.open() end)
