-- init.lua is what is getting read. it initalizes the directory 
-- so here we can grab our lazyvim config

-- How does this know to point to /lua/config/lazy
-- and not just /config/lazy  [????]
--vim.cmd("set mouse=a")
require("config.lazy")
require("keys")
require("opt")
-- Not entirely sure what this section is doing but it make the background clear:
vim.cmd([[
  hi Normal       guibg=NONE ctermbg=NONE
  hi NormalNC     guibg=NONE ctermbg=NONE
  hi SignColumn   guibg=NONE ctermbg=NONE
  hi VertSplit    guibg=NONE ctermbg=NONE
  hi EndOfBuffer  guibg=NONE ctermbg=NONE
]])


-- ==================================== --
-- ========= Treesitter Init ========== --
-- ==================================== --
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- ==================================== --
-- ========== Telescope Init ========== --
-- ==================================== --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = 'Telescope colorscheme' })


-- ==================================== --
-- ====== Telescope File Browser ====== --
-- ==================================== --
-- You don't need to set any of these options.
-- IMPORTANT!: this is only a showcase of how you can set default options!
require("telescope").setup {
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"

-- create a group to keep things tidy
vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    -- highlight with the 'IncSearch' group for 200ms
    vim.highlight.on_yank {
      higroup  = "IncSearch",
      timeout  = 200,
      on_visual = false,  -- set to true if you also want to flash visual-mode yanks
    }
  end,
})
