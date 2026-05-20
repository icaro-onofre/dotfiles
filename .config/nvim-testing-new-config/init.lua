-- :lua print(vim.fn.stdpath('cache') .. '/dap.log') -- PRINT DAP LOGS
-- =========================================================
-- BOOTSTRAP LAZY.NVIM
-- =========================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.o.winbar = "%<%f %h%m%r%=%{getcwd()}"

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
-- MASON PACKAGE MANAGER
"folke/which-key.nvim",
{ "folke/neoconf.nvim", cmd = "Neoconf" },
-- "folke/neodev.nvim",

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
{ 'mfussenegger/nvim-dap' },
{
  "microsoft/vscode-js-debug",
  build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
},
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
vim.cmd("colorscheme zaibatsu")

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
-- -------- Selection --------
-- vim.keymap.set('x', 'an', function()
--   vim.lsp.buf.selection_range('outer')
-- end, { desc = "vim.lsp.buf.selection_range('outer')" })
--
-- vim.keymap.set('x', 'in', function()
--   vim.lsp.buf.selection_range('inner')
-- end, { desc = "vim.lsp.buf.selection_range('inner')" })

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
vim.keymap.set('n', '<leader>r', builtin.lsp_references)
vim.keymap.set('n', '<leader>pd', builtin.diagnostics)
vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols)

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
vim.lsp.enable({
  'tailwindcss',
  'ts_ls',
  'jdtls',
  'dartls',
  'gopls',
  'html',
})

-- HTML LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
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
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help)

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

-- BEGIN GO DAP configuratino
dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}
dap.configurations.go = {
  -- 1. Debug the current file / package
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  -- 2. Debug the whole package (useful for multi-file packages)
  {
    type = "go",
    name = "Debug package",
    request = "launch",
    program = "${fileDirname}",
  },
  -- 3. Debug with arguments
  {
    type = "go",
    name = "Debug with args",
    request = "launch",
    program = "${fileDirname}",
    args = function()
      local args_str = vim.fn.input("Arguments: ")
      return vim.split(args_str, " ", { trimempty = true })
    end,
  },
  -- 4. Debug test file
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- 5. Debug specific test function
  {
    type = "go",
    name = "Debug test function",
    request = "launch",
    mode = "test",
    program = "${fileDirname}",
    args = function()
      local test_name = vim.fn.input("Test name (regexp): ")
      return { "-test.run", test_name }
    end,
  },
  -- 6. Attach to a running process
  {
    type = "go",
    name = "Attach to process",
    request = "attach",
    mode = "local",
    processId = require("dap.utils").pick_process,
  },
  -- 7. Attach to a remote delve server
  {
    type = "go",
    name = "Attach to remote (127.0.0.1:2345)",
    request = "attach",
    mode = "remote",
    host = "127.0.0.1",
    port = "2345",
  },
}
-- END GO DAP configuration
  
-- Chrome debugger
-- TODO corrigir o dap adapter para o chrome, para que eu consiga debuggar aplicativos em REACT
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = {os.getenv("HOME") .. ".local/share/nvim/lazy/vscode-js-debug/src/dapDebugServer.ts"}
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

-- BEGIN BUN DAP configuration
dap.adapters.bun = {
  type    = "executable",
  command = "bun",
  args    = { "--inspect-brk" },
}

dap.adapters.chrome = {
  type    = "executable",
  command = "node",
  args    = {
    vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js",
  },
}

dap.adapters.msedge = {
  type    = "executable",
  command = "node",
  args    = {
    vim.fn.stdpath("data") .. "/mason/packages/edge-debug-adapter/out/src/edgeDebug.js",
  },
}
-- END BUN DAP configuratino

-- RUST DAP configuration
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.rust = {
  {
    name = "Launch binary",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Points to your compiled binary
      return vim.fn.input("Path to binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
-- END RUST DAP configuratino

-- Flutter / Dart debugging
-- dap.adapters.dart = {
--   type = 'executable',
--   command = 'dart',
--   args = { 'debug_adapter' },
--   options = { detached = false }
-- }
--
-- dap.adapters.flutter = {
--   type = 'executable',
--   command = 'flutter',
--   args = { 'debug_adapter' },
--   options = { detached = false }
-- }
--
-- dap.configurations.dart = {
--   {
--     type = "dart",
--     request = "launch",
--     name = "Launch dart",
--     dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart",
--     flutterSdkPath = "/opt/flutter/bin/flutter",
--     program = "${workspaceFolder}/lib/main.dart",
--     cwd = "${workspaceFolder}",
--   }
-- }
-- END flutter debugging

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
