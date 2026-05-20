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
{
    "mason-org/mason.nvim",
    opts = {}
},

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
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},

-- =========================
-- Debugging
-- =========================
{
  -- Core DAP plugin
  "mfussenegger/nvim-dap",
  event = "VeryLazy",  -- Load lazily for performance[citation:5]
  dependencies = {
    -- -- DAP UI for better debugging experience
    -- "rcarriga/nvim-dap-ui",
    -- dependencies = { "nvim-neotest/nvim-nio" },
    
    -- Mason integration for DAP
    "jay-babu/mason-nvim-dap.nvim",
    
    -- Optional: Virtual text for DAP variables
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    -- local dapui = require("dapui")
    
    -- Setup DAP UI
    -- dapui.setup()
    
    -- Setup virtual text
    require("nvim-dap-virtual-text").setup()
    
    -- Setup Mason DAP integration
    require("mason-nvim-dap").setup({
      -- Automatically install these adapters
      ensure_installed = {
        "delve",        -- Go
        "debugpy",      -- Python
        "codelldb",     -- C/C++/Rust
        "js-debug-adapter", -- JavaScript/TypeScript
      },
      
      -- Auto-install adapters when needed
      automatic_installation = true,
      
      -- Automatically configure dap for installed adapters
      automatic_setup = true,  -- This does the magic![citation:8]
      
      -- Custom handlers for specific adapters (if needed)
      handlers = {
        -- Example: Custom Python debugger config
        python = function(config)
          config.adapters = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" }
          }
          require("mason-nvim-dap").default_setup(config)
        end,
      }
    })
    
    -- Key mappings for debugging
    vim.keymap.set('n', '<F5>', dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "Debug: Open REPL" })
    -- vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = "Debug: Toggle UI" })
    
    -- Auto-open/close DAP UI when debugging starts/stops
    -- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    -- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    -- dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
},
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
vim.keymap.set('n', '<leader>s', "<Cmd>w<CR>")
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
vim.keymap.set('n', '<leader>pd', builtin.diagnostics)
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
