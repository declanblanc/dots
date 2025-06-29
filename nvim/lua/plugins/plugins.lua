return {
{
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    require "plugins.configs.lspconfig"
  end,
},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
  	dependencies = {
    "williamboman/mason.nvim",
  	},
  config = function()
    require("mason-lspconfig").setup {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "html",
        "cssls",
        "ts_ls",
      },
    }
  end,
}, 
{ "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    require "plugins.configs.cmp"
  end,},
  {
  "m4xshen/autoclose.nvim",
  event = "InsertEnter", -- optional lazy load on InsertEnter
  config = function()
    require("autoclose").setup()
  end,
}
}
