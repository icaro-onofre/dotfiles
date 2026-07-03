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
-- Catpuccin theme
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  
-- Open code integration
-- {
--   "nickjvandyke/opencode.nvim",
--   version = "*", -- Latest stable release
--   config = function()
--     ---@type opencode.Opts
--     vim.g.opencode_opts = {
--       -- Your configuration, if any; goto definition on the type or field for details
--     }
--
--     vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`
--
--     -- Recommended/example keymaps
--     vim.keymap.set({ "n", "x" }, "<F3>", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
--     vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,       { desc = "Select OpenCode…" })
--
--     -- vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Append range to OpenCode", expr = true })
--     -- vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Append line to OpenCode", expr = true })
--
--     -- vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll OpenCode up" })
--     -- vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })
--   end,
-- },

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
-- Completion
-- =========================
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},

-- =========================
-- Flutter configuration
-- =========================

-- =========================
-- Debugging
-- =========================
{
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")

    require("nvim-dap-virtual-text").setup()

    require("mason-nvim-dap").setup({
      ensure_installed = {
        "delve",
        "debugpy",
        "codelldb",
        "js-debug-adapter",
      },
      automatic_installation = true,
      automatic_setup = true,
      handlers = {
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

    -- ─── Chrome / JS-debug adapter ──────────────────────────────────────────

    -- js-debug-adapter is installed by Mason to this path
    local js_debug_path = vim.fn.stdpath("data")
      .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

    -- Single adapter entry covers pwa-chrome AND pwa-node
    for _, type in ipairs({ "pwa-chrome", "pwa-node" }) do
      dap.adapters[type] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_debug_path, "${port}" },
        },
      }
    end

    -- TypeScript launch configurations
	for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
    dap.configurations[language] = {

      -- Attach to an already-running Chrome instance
      -- Start Chrome with: google-chrome --remote-debugging-port=9222
	    {
		type = "pwa-node",
		request = "launch",
		name = "Debug Bun (file)",
		runtimeExecutable = "bun",
		runtimeArgs = { "--inspect-brk" },
		program = "${file}",
		cwd = "${workspaceFolder}",
		attachSimplePort = 6499, -- Bun's default inspect port
	  },
      {
        type    = "pwa-chrome",
        request = "attach",
        name    = "Attach to Chrome (port 9222)",
        port    = 9222,
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        -- Tells the adapter where compiled JS lives relative to your TS sources
        -- Adjust if your outDir differs from the default
        sourceMapPathOverrides = {
          ["webpack:///./~/*"]   = "${workspaceFolder}/node_modules/*",
          ["webpack://?:*/*"]    = "${workspaceFolder}/*",
          ["webpack:///src/*"]   = "${workspaceFolder}/src/*",
          ["meteor://💻app/*"]  = "${workspaceFolder}/*",
        },
      },

      -- Launch a new Chrome window pointing at your dev server
      {
        type    = "pwa-chrome",
        request = "launch",
        name    = "Launch Chrome against localhost",
        url     = "http://localhost:3000",   -- change to your dev server port
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        sourceMapPathOverrides = {
          ["webpack:///./~/*"]  = "${workspaceFolder}/node_modules/*",
          ["webpack://?:*/*"]   = "${workspaceFolder}/*",
          ["webpack:///src/*"]  = "${workspaceFolder}/src/*",
          ["meteor://💻app/*"] = "${workspaceFolder}/*",
        },
      },

      -- Node / ts-node for server-side TypeScript (bonus)
      {
        type    = "pwa-node",
        request = "launch",
        name    = "Launch with ts-node",
        program = "${file}",
        runtimeExecutable = "ts-node",
        sourceMaps = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      },
      -- ── Bun: launch current file ──────────────────────────────────────────
    }
	end

	dap.adapters.dart = {
	  type = "executable",
	  command = "dart",
	  args = { "debug_adapter" },
	}

	-- For Flutter projects, use the Flutter SDK's adapter instead:
	dap.adapters.flutter = {
	  type = "executable",
	  command = "flutter", -- must be in your PATH
	  args = { "debug_adapter" },
	}

	dap.configurations.dart = {
	  {
		type = "dart",
		request = "launch",
		name = "Launch Dart Program",
		program = "${file}",
		cwd = "${workspaceFolder}",
	  },
	  {
		type = "flutter",
		request = "launch",
		name = "Launch Flutter",
		program = "${workspaceFolder}/lib/main.dart",
		cwd = "${workspaceFolder}",
	  },
	}

	-- Golang debugging
	dap.adapters.go = {
	  type = "server",
	  port = "${port}",
	  executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	  },
	}

	dap.configurations.go = {
	  {
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	  },
	  {
		type = "go",
		name = "Debug Package",
		request = "launch",
		program = "${workspaceFolder}",
	  },
	  {
		type = "go",
		name = "Attach to Process",
		request = "attach",
		mode = "local",
		processId = require("dap.utils").pick_process,
	  },
	}

    -- Also apply the same configs to plain JS files
    dap.configurations.javascript = dap.configurations.typescript

    -- ─── Key mappings ───────────────────────────────────────────────────────

    vim.keymap.set('n', '<F5>',       dap.continue,          { desc = "Debug: Start/Continue" })
    vim.keymap.set('n', '<F10>',      dap.step_over,         { desc = "Debug: Step Over" })
    vim.keymap.set('n', '<F11>',      dap.step_into,         { desc = "Debug: Step Into" })
    vim.keymap.set('n', '<F12>',      dap.step_out,          { desc = "Debug: Step Out" })
    vim.keymap.set('n', '<F9>',  dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set('n', '<Leader>dr', dap.repl.open,         { desc = "Debug: Open REPL" })
  end,
},
{
  "akinsho/flutter-tools.nvim", -- purpose-built Flutter plugin, handles DAP for you
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional, nicer UI for selecting devices
  },
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
vim.cmd("colorscheme catppuccin-macchiato ")

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
vim.keymap.set('n', '<leader>q', "<Cmd>bd<CR>")
vim.keymap.set('n', '<leader>R', "<Cmd>source %<CR>")

vim.keymap.set("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy full file path" })
vim.keymap.set("n", "<leader>cf", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Copy file name" })

-- -------- Quickfix --------
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>')

-- -------- Motion --------
vim.keymap.set('n', '<leader>w', '<Cmd>HopWordMW<CR>')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- -------- Telescope --------
require('telescope').setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        width = 0.99,
        height = 0.99,
        preview_width = 0.5,
      },
    },
	border = false,
  },
})


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
-- Java LSP setup
vim.lsp.config('jdtls', {
  cmd = {
    'jdtls',
    '-data', vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
  },
  filetypes = { 'java' },
  root_markers = { 'pom.xml', 'build.gradle', 'build.gradle.kts', '.git' },
})

vim.lsp.enable('jdtls')

-- Lua lsp setup
-- vim.lsp.config['emmylua_ls'] = {
--   -- Command and arguments to start the server.
--   cmd = { 'emmylua_ls' },
--   -- Filetypes to automatically attach to.
--   filetypes = { 'lua' },
--   -- Sets the workspace "root" to the directory where any of these files is found.
--   -- Files sharing a root will reuse the LSP client/connection.
--   -- Nested lists indicate equal priority, see |vim.lsp.Config|.
--   root_markers = { { '.emmyrc.json', '.luarc.json' }, '.git' },
--   -- Server-specific settings. https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md
--   settings = {
--     runtime = {
--       version = 'LuaJIT',
--     }
--   }
-- }
-- vim.lsp.enable('emmylua_ls')

-- Golang lsp setup
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable("gopls")
  
-- Dart lsp setup
vim.lsp.config("dartls", {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_markers = { "pubspec.yaml", ".git" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = true,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})

vim.lsp.enable("dartls")

-- Typescript lsp setup
vim.lsp.config('typescript-language-server', { -- Ensure installed with npm 
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'tsconfig.json', 'package.json' },
})

vim.lsp.enable('typescript-language-server')  
-- =========================================================
-- LSP AUTOCOMMANDS
-- =========================================================
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local buf = args.buf
    local opts = { buffer = buf }

	-- vim.keymap.set('n', 'gE', function()
	--   vim.diagnostic.open_float({ focusable = true })
	-- end)
    vim.keymap.set('n', 'K',          	vim.lsp.buf.hover,            opts)
    vim.keymap.set('n', 'gd',         	vim.lsp.buf.definition,       opts)
    vim.keymap.set('n', 'gr',         	vim.lsp.buf.references,       opts)
    vim.keymap.set('n', 'ga', 			vim.lsp.buf.code_action,      opts)
    vim.keymap.set('n', '<leader>rn', 	vim.lsp.buf.rename,           opts)
	vim.keymap.set('n', 'gi', 			vim.lsp.buf.implementation)
    vim.keymap.set('i', '<C-k>',      	vim.lsp.buf.signature_help,   opts)
	vim.keymap.set('n', 'go', 		  	vim.lsp.buf.type_definition)
	vim.keymap.set('n', 'gD', 		  	vim.lsp.buf.declaration)
	vim.keymap.set('n', '[d', 		  	vim.diagnostic.goto_next)
	vim.keymap.set('n', ']d', 		  	vim.diagnostic.goto_prev)
	-- vim.keymap.set('n', '<leader>fy', 			vim.lsp.buf.format)
  end
})
-- =========================================================
-- LSP KEYMAPS
-- =========================================================



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
-- FLUTTER tools setup
-- =========================================================
require("flutter-tools").setup({
  debugger = {
    enabled = true,
    run_via_dap = true, -- hooks into nvim-dap automatically
  },
  widget_guides = { enabled = true },
  closing_tags = { enabled = true },
  dev_log = { enabled = true, open_cmd = "tabedit" },
  dev_tools = {
    autostart = true, -- auto-launch DevTools server
    auto_open_browser = false,
  },
})
