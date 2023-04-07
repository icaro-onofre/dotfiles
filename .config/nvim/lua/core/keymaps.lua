vim.g.mapleader = ' '

--Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--Treesitter
vim.keymap.set('n', '<leader>t', ':TSEnable hightlight <CR>')
--Prettier
vim.keymap.set('n', '<leader>ap', ':Prettier<CR>')
--General purpose keybindings

vim.keymap.set('n', '<leader>rr', ":checktime <CR>")
vim.keymap.set('n', '<leader>rb', ":source % <CR>")
--Telescope keybindings
-- Code running
vim.keymap.set('n', '<leader>rp', ':!python %<CR>')
-- Gitsigns keybindings
vim.keymap.set('n', '<leader>gs', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', '<leader>gu', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', '<leader>gb', ':Gitsigns stage_buffer<CR>')
vim.keymap.set('n', '<leader>gj', ':Gitsigns next_hunk<CR>')
vim.keymap.set('n', '<leader>gk', ':Gitsigns prev_hunk<CR>')
-- Vim fugitive
vim.keymap.set('n', '<leader>gg', ':Git<CR>')
vim.keymap.set('n', '<leader>gc', ':Git commit -m "')
-- NERDTree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
-- diffview
vim.keymap.set('n', '<leader>gw', ':DiffviewFileHistory<CR>')
vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>gq', ':DiffviewClose<CR>')
