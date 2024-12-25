return{

    { 'tpope/vim-sleuth' },
    { 'numToStr/Comment.nvim', opts = {} },

    {
      'lewis6991/gitsigns.nvim',
      opts = {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      },
    },

    {
      'folke/which-key.nvim',
      event = 'VimEnter',
      config = function()
        require('which-key').setup()
        require('which-key').add {
          { '<leader>c', group = '[C]olorscheme' },
          { '<leader>d', group = '[D]ocument' },
          { '<leader>r', group = '[R]ename' },
          { '<leader>s', group = '[S]earch' },
          { '<leader>w', group = '[W]orkspace' },
          { '<leader>t', group = '[T]oggle' },
          { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        }
      end,
    },


    {
      'folke/todo-comments.nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {
        keywords = {
          FIX  = { icon = " ", color = "#ef2f27", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "PROBLEME" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "#fbb829", alt = { "QUESTION" } },
          WARN = { icon = " ", color = "#fbb829", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      }
    },
--    {
--       "rcarriga/nvim-notify",
--	config = function()
--	  require("notify").setup({
--	  timeout = 1000,
--	  stages = 'fade_in_slide_out'
--	  })
--         vim.notify = require("notify")
--	end,
--    },
    {
       "folke/noice.nvim",
       event = "VeryLazy",
       opts = {
       },
       dependencies = {
         "MunifTanjim/nui.nvim",
         "rcarriga/nvim-notify",
       },
        require("noice").setup({
          lsp = {
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
          },
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
      })
    },

    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        bigfile = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = false },
        words = { enabled = true },
      },
    },

    {
      'echasnovski/mini.nvim',
      config = function()
        require('mini.ai').setup { n_lines = 500 }
        require('mini.surround').setup()
      end,
    },

    { 'rktjmp/lush.nvim' },

    {
     'brenoprata10/nvim-highlight-colors',
      config = function()
        require('nvim-highlight-colors').setup()
      end,
    },

    {
      'ggandor/leap.nvim',
      config = function()
        vim.keymap.set({'n'}, '<leader>f',  '<Plug>(leap)')
        --vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
        --vim.keymap.set({'n', 'x', 'o'}, 'gs',  '<Plug>(leap-backward)')
        --vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-from-window)')
      end,
    },

}
