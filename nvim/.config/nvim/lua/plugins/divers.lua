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

  


  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {

      keywords = {
        FIX  = { icon = " ", color = "#ef2f27", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "PROBLEME" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "#fbb829", alt = { "QUESTION" } },
        WARN = { icon = " ", color = "#fbb829", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    } -- end of opts
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      ---local statusline = require 'mini.statusline'
      ---statusline.setup { use_icons = vim.g.have_nerd_font }
      --- @diagnostic disable-next-line: duplicate-set-field
      ---statusline.section_location = function()
      ---  return '%2l:%-2v'
      ---end
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
      'ron89/thesaurus_query.vim',
      init = function()
        vim.g.tq_enabled_backends = {'synonymo_fr', 'cnrtl_fr'}
        vim.g.tq_language = 'fr'
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


    {
      'dbmrq/vim-ditto',
      init = function()
        vim.g.ditto_min_repetitions = 3
      end,
    },

    {
      'vimwiki/vimwiki',
      init = function()
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_listsyms = ' ○◐●✓'
        vim.g.vimwiki_folding = 'expr:quick'
        vim.g.vimwiki_list = {{path= '~/Documents/notes', syntax= 'markdown', ext= '.md', path_html= '~/Documents/notes/html/', custom_wiki2html= 'vimwiki_markdown'}}
      end,
    },



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

    {
      'dpelle/vim-Grammalecte',
      init = function()
        vim.g.grammalecte_cli_py ='$HOME/.config/Grammalecte-fr-v2.1.1/grammalecte-cli.py'
      end,

    },
    {
      'dpelle/vim-LanguageTool',
      init = function()
        vim.g.languagetool_jar ='$HOME/.config/LanguageTool-6.5/languagetool-commandline.jar'
        languagetool_lang = 'fr'
      end,

    },



}
