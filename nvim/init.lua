-- This is a comment in Lua!

-- This is an example of using the global vim variable
-- vim.opt.option_name = value

-- I am following a guide found at https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/

-- These are "imports" much like the #include in C/C++
require("config.lazy")
require("mason").setup()
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Creates "op" as an abbreviation for typing 'vim.opt' 
Op = vim.opt


Op.termguicolors = true
-- Enables line numbers in "the gutter" (the left of the window)
Op.number = true
-- Changes number display to show line numbers relative to cursor line
Op.relativenumber = true

-- Enables the mouse for all modes ('a' is all modes)
Op.mouse = 'a'

-- Ignores capitalization when using the search function.
Op.ignorecase = true

-- Disables "highlight search" for the last searched word.
Op.hlsearch = false

-- Wraps lines that exceed the window width so text is always visible
Op.wrap = true
Op.linebreak = true
Op.textwidth = 0
-- Makes sure indented lines keep their indentation when wrapping
Op.breakindent = true
	-- This is a line that will wrap and has some indentation so as you can see with the previous option enabled, the wrapped line still begin with two tabs

-- Modified the size a tab character occupies on the screen. The default value is 8.
Op.tabstop = 4
-- Similar to the previous option, this will change the amount of characters nvim will use to indent a line (using << and >>). Should be the same as tabstOp.
Op.shiftwidth = 4

-- This option decides if nvim should transform a `Tab` into multiple spaces. Default is false but also setting it here for some reason.
Op.expandtab = false

-- This option should ensure a minimum number of lines above and below the cursor when navigating a file
Op.scrolloff = 20




-- Moving on from options to keybindings
-- my own shortcut for this setting
Key = vim.keymap.set

-- What are the parameters for this module?
-- key({mode}, {lhs}, {rhs}, {opts})
-- {mode} can be one or more of the neovim modes 
				-- normal 'n'
				-- insert 'i'
				-- visual 'x'
				-- visual + selection 'v'
				-- terminal 't'
				-- etc.
-- {lhs} is the key or sequence we want to bind
-- {rhs} is the command/action we want to execute. Can also take a lua function
-- {opts} takes a lua table as an argument.
				-- desc - a string describing what the keybind does. Can be anything
				-- remap - a boolean that determines if the keybind can be recursive. Default is false. Will be explained later
				-- buffer - boolean or number. `true` means the keybind will only affect the current file. Assigning a number attaches it to the `id` of an open buffer
				-- silent - boolean determines whether binds show a message. default is false
				-- expr - boolean that if enabled gives the chance to use vimscript or lua to calculate the value of rhs. default false


-- The "leader" key is a global variable that can be a string.
vim.g.mapleader = ' '
-- This changes what key is selected when we type <leader> for our bindings. I've set it to space

-- This allows us to save a file with the sequence "Space + w"
Key('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})

-- Straying from the tutorial a bit to find a way to center my cursor on the screen. ChatGPT to the rescue??
-- This seems to work for now. but is a bit jank and doesn't work in insert mode. So jumping from insert to normal can be jarring
-- TODO: Improve this

-- This remap sets the sequence 'gy' to copy to system clipboard
Key({'n', 'x'}, 'gy', '"+y', {desc = 'System Copy'})
-- This remap sets the sequence 'gp' to paste from system clipboard
Key({'n', 'x'}, 'gp', '"+p', {desc = 'System Paste'})

-- Typically when deleting in vim, this will modify the clipboard register, the following binds set x and X to delete a character or act as d respectively just without modifying the registers.
Key({'n', 'x'}, 'x', '"_x', {desc = 'Del char without yank'})
Key({'n', 'x'}, 'X', '"_d', {desc = 'Del without yank'})

-- This shortcut (space + a), will select all text in current buffer
Key('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- The following shortcuts allow quick access to telescope features
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Mapping nvim tree binds
Key('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', { desc = 'Open NvimTree' })


--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- The following keymaps change the default functionality of j and k for navigating wrapped lines. Now, unless a number(v:count) is specified, j and k will really be gj and gk. This allows for more sensible navigation of wrapped lines (such as this one!)
vim.keymap.set("n", "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { expr = true })

vim.keymap.set("n", "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { expr = true })


-- The following keybinds are related to navigating tabs in nvim
Key('n', '<leader>ee', '<cmd>tabnew<cr>', { desc = 'Open new tab' })
Key('n', '<leader>er', '<cmd>tabn<cr>', { desc = 'Navigate to next tab' })
Key('n', '<leader>ew', '<cmd>tabp<cr>', { desc = 'Navigate to previous tab' })
Key('n', '<leader>ed', '<cmd>tabc<cr>', { desc = 'Close the current tab' })


require('lualine').setup({
	options = {
		theme='gruvbox-material',
		section_separators = '',
    component_separators = ''
	}
})



function ColorMyPencils(color)
  color = color or "monokai-pro"
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
