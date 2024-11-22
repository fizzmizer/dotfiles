return{
    {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
    },

    {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"mason.nvim"},
    config = function()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
          function (server_name)
              require("lspconfig")[server_name].setup({})
          end,
      }
    end,
    },

    {"neovim/nvim-lspconfig"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/nvim-cmp"},
}
