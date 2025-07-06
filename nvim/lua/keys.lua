vim.g.mapleader = ' '

-- This remap sets the sequence 'gy' to copy to system clipboard
vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'System Copy'})

-- This remap sets the sequence 'gp' to paste from system clipboard
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'System Paste'})

-- Typically when deleting in vim, this will modify the clipboard register, the following binds set x and X to delete a character or act as d respectively just without modifying the registers.
vim.keymap.set({'n', 'x'}, 'x', '"_x', {desc = 'Del char without yank'})
vim.keymap.set({'n', 'x'}, 'X', '"_d', {desc = 'Del without yank'})

-- The following shortcuts allow quick access to telescope features
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- keymap to open telescope file browser
vim.keymap.set("n", "<leader>t", ":Telescope file_browser path=%:p:h select_buffer=true<CR><Esc>", {desc = 'Open file browser'})

-- keymap to save
vim.keymap.set("n", "<leader>w", ":w<CR>", {desc = 'Save file'})

vim.keymap.set("n", "<leader>a", "G$vH0", {desc = 'Select all'})

