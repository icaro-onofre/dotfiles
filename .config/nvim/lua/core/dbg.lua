require"telescope".load_extension"dap"

local keymap_opts_with_silent = { noremap = true, silent = true }

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
vim.keymap.set('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
vim.keymap.set('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
vim.keymap.set('v', '<leader>dhv',
          '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

vim.keymap.set('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
vim.keymap.set('n', '<leader>duf',
          "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

vim.keymap.set('n', '<leader>dsbr',
          '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
vim.keymap.set('n', '<leader>dsbm',
          '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
vim.keymap.set('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
vim.keymap.set('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')


-- telescope-dap
vim.keymap.set('n', '<leader>dcc',
          '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
vim.keymap.set('n', '<leader>dco',
          '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
vim.keymap.set('n', '<leader>dlb',
          '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
vim.keymap.set('n', '<leader>dv',
          '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
vim.keymap.set('n', '<leader>df',
          '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
	  --
--Dap UI setup
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

--Python dap config
require('dap-python').setup('~/miniconda3/bin/python')
--Javascript dap config 

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "3000",
  executable = {
    command = "node",
    args = {"~/.dap/js-debug/src/dapDebugServer.js", "3000"},
  }
}

require("dap").configurations.javascript = {
  {
    name = "Launch file",
    type = "pwa-node",
    request = "launch",
    reAttach = true,
    url = "http://localhost:3000",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}
