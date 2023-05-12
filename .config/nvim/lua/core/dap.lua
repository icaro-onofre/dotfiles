local vim = vim -- to avoid undefined vim warning all down the file

local keymap_opts = { noremap = true }
local keymap_opts_with_silent = { noremap = true, silent = true }

local dap_install = require("dap-install")

dap_install.setup({
  installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
  verbosely_call_debuggers = true
})
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
for _, debugger in ipairs(dbg_list) do
  dap_install.config(debugger)
end

require("dap-ruby").setup()
require("nvim-dap-virtual-text").setup() -- cannot see virtual text if Treesitter for a language is not installed

-- DAP bindings or mappings
vim.api.nvim_set_keymap('n', "<leader>dc", ":lua require'dap'.continue()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>do", ":lua require'dap'.step_over()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>di", ":lua require'dap'.step_into()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>dx", ":lua require'dap'.step_out()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
  , keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>dl",
  ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>dr", ":lua require'dap'.repl.open()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>drl", ":lua require'dap'.run_last()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>dev", ":lua require('dapui').eval()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>dclose", ":lua require('dapui').close()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('n', "<leader>de", ":lua require('dap').close()<CR>", keymap_opts_with_silent)
vim.api.nvim_set_keymap('v', "<leader>dev", ":lua require('dapui').eval()<CR>", keymap_opts_with_silent)

require('telescope').load_extension('dap')
require('telescope').load_extension('metals')
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

