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
  "mfussenegger/nvim-dap" ,
  "rcarriga/nvim-dap-ui" ,
  "mxsdev/nvim-dap-vscode-js" ,
  "nvim-neotest/nvim-nio" ,

})


-- init.lua or in lua/plugins/dap.lua
-- Requires: mfussenegger/nvim-dap, rcarriga/nvim-dap-ui, mxsdev/nvim-dap-vscode-js, nvim-neotest/nvim-nio

-- Install via packer.nvim (example)

-- Path to vscode-js-debug
-- Clone once:
--   git clone https://github.com/microsoft/vscode-js-debug.git
--   cd vscode-js-debug
--   npm install && npm run compile
-- Adapter path: ./vscode-js-debug/out/src

local dap = require("dap")
local dapui = require("dapui")

-- Setup UI
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Setup JS/TS adapter
require("dap-vscode-js").setup({
  debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter", -- if installed via mason
  adapters = { "pwa-node", "pwa-chrome", "node-terminal", "pwa-extensionHost" }, -- which adapters to register
})

-- Language specific configs
for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
    },
  }
end

-- Keymaps
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP Run Last" })
