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
