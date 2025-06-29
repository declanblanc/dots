-- lua/plugins/monokai-pro.lua
return {
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,  -- optional, ensures this colorscheme loads first
    config = function()
      -- You can pass settings to the plugin before loading the colorscheme:
      require("monokai-pro").setup({
        -- see plugin's README for options, e.g.:
        filter = "classic", -- or "spectrum", "classic", "octagon", "ristretto", "machine"
        -- day_night = { day_filter = 'pro', night_filter = 'spectrum' },
      })

      -- Finally, tell Neovim to use this colorscheme
			vim.opt.termguicolors = true
      vim.cmd("colorscheme monokai-pro")
    end,
  },
	{
		'nvim-lualine/lualine.nvim',
  	dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
}
