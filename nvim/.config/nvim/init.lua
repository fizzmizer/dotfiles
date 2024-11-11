-- vim: ts=1 sts=2 sw=2 et
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.hlsearch = true
vim.opt.foldenable = false
vim.opt.spell = true
vim.opt.spelllang = {'fr', 'en_gb'}
vim.opt.termguicolors = true


-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<c-z>', '<nop>')
vim.keymap.set('i', '<c-c>', 'Ç')
vim.keymap.set('i', '<c-e>', '<Esc>')
vim.keymap.set('i', '<c-x><c-s>', '<Esc>:w<CR>a')
vim.keymap.set('n', '<c-x><c-s>', '<Esc>:w<CR>')
vim.keymap.set('n', '<c-s><c-y>', ':ThesaurusQueryReplaceCurrentWord<CR>')
vim.keymap.set('n', 'gn', ':tabnew<Space>')
vim.keymap.set('n', 't', 'F')
vim.keymap.set('n', 'F', 't')
vim.keymap.set('i', '&à', 'À')
vim.keymap.set('i', '&é', 'É')
--vim.keymap.set('n', '<c-c><c-l>', ':!pdflatex %<CR>')
--vim.keymap.set('n', '<c-c><c-b>', ':!biber --isbn-normalise %:r<CR>')
vim.keymap.set('n', 'zz', '1z=')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', ':', ':<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')
vim.keymap.set('i', '!', '!<c-g>u')
vim.keymap.set('i', '?', '?<c-g>u')
vim.keymap.set('i', '(', '<c-g>u(')
vim.keymap.set('i', ')', '<c-g>u)')
vim.keymap.set('n', 'zv', '[s')
vim.keymap.set('n', 'zs', ']s')


local function getWords()
    -- the third string here is the string for visual-block mode (^V)
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
        return vim.fn.wordcount().visual_words .. " words"
    else
        return vim.fn.wordcount().words .. " words"
    end
end

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--  To update plugins you can run
--    :Lazy update

require('lazy').setup({
  'tpope/vim-sleuth',
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
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>cs', builtin.colorscheme, { desc = 'colorscheme switcher' })
      --vim.keymap.set('n', 'zz', builtin.spell_suggest, {}) 
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

    {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.hi 'Comment gui=none'
    end,
  },

    {
    'srcery-colors/srcery-vim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.g.srcery_italic = 1
      --vim.cmd.colorscheme 'srcery'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {'raddari/last-color.nvim'},

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
        vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, 'gs',  '<Plug>(leap-backward)')
        vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-from-window)')
      end,
    },

    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
          require('lualine').setup{
            options = { theme = 'sorciere',
            section_separators = { left = '', right = ''},
            --section_separators = { left = '', right = '' },
            },
            sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch', 'diff', 'diagnostics'},
              lualine_c = {'filename', {getWords}},
              lualine_x = {'encoding', 'fileformat', 'filetype'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
            },
          }
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
      "lervag/vimtex",
      lazy = false,
      init = function()
        vim.g.vimtex_fold_enabled = true
        vim.g.vimtex_view_method = 'zathura'
        --vim.g.vimtex_view_general_viewer = 'okular'
        --vim.g.vimtex_quickfix_open_on_warning = 0  
        vim.g.vimtex_quickfix_ignore_filters = {
       'Underfull',
       'Overfull',
       'LaTeX hooks Warning',
       'Package siunitx Warning: Detected the "physics" package:',
       'Package hyperref Warning: Token not allowed in a PDF string',
       'Package fancyhdr Warning',
       'Package todonotes Warning',
      }

      local au_group = vim.api.nvim_create_augroup("vimtex_events", {})
       vim.api.nvim_create_autocmd("User", {
            pattern = "VimtexEventQuit",
            group = au_group,
            command = "VimtexClean",
        })
      end
    },


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


    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*', 
      build = 'make install_jsregexp'
    },

}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- default theme as a backup, `recall()` can return `nil`.
local theme = require('last-color').recall() or 'default'
vim.cmd.colorscheme(theme)

--vim.api.nvim_create_autocmd('VimLeave',
--    {
--      pattern = '*',
--      command = '!rubber --clean % && rm *.out'
--    }
--)


require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",

  update_events = 'TextChanged,TextChangedI'
})


vim.cmd[[

" Expand or jump in insert mode
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 

" Jump forward through tabstops in visual mode
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Jump backward through snippet tabstops with Shift-Tab (for example)
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

" Cycle forward through choice nodes with Control-f (for example)
" imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
" smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'

]]

-- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/luasnippets/"})

vim.api.nvim_create_autocmd('FileType',

{
    pattern = 'tex',
    callback = function()
      --vim.keymap.set('i', '&ii', 'Írisz')
      --vim.keymap.set('i', '&fr','\\begin{frame}<Enter>\\frametitle{}<Enter><Enter><++><Enter><Enter>\\end{frame}<Enter><Enter><++><Esc>6kf}i')
      --vim.keymap.set('i', '&it','\\textit{} <++><Esc>T{i')
      --vim.keymap.set('i', '&bf','\\textbf{} <++><Esc>T{i')
      --vim.keymap.set('i', '&up','\\usepackage{}<++><Esc>T{i')
      -- vim.keymap.set('i', '&en','\\begin{enumerate}<Enter><Enter>\\end{enumerate}<Enter><Enter><++><Esc>3kA\\item<Space>')
      -- vim.keymap.set('i', '&bit','\\begin{itemize}<Enter><Enter>\\end{itemize}<Enter><Enter><++><Esc>3kA\\item<Space>')
      vim.keymap.set('i', '&li','<Esc>A<Enter>\\item<Space>')
      -- vim.keymap.set('i', '&chap','\\chapter{}<Enter><Enter><Enter><++><Esc>3kf}i')
      -- vim.keymap.set('i', '&sec','\\section{}<Enter><Enter><Enter><++><Esc>3kf}i')
      -- vim.keymap.set('i', '&ssec','\\subsection{}<Enter><Enter><Enter><++><Esc>3kf}i')
      -- vim.keymap.set('i', '&sssec','\\subsubsection{}<Enter><Enter><Enter><++><Esc>3kf}i')
      --vim.keymap.set('i', '&"','«~~»<++><Esc>5hi')
      --vim.keymap.set('i', '&-','---~')
      --vim.keymap.set('i', '&vs','\\vspace{}<++> <Esc>5hi')
      --vim.keymap.set('i', '&v1','\\vspace{1em}<CR><CR>')
      -- vim.keymap.set('i', '&mn','\\begin{minipage}{.48\\textwidth}<CR>\\end{minipage}\\hfill<CR>\\begin{minipage}{.48\\textwidth}<CR><++><CR>\\end{minipage}<CR><CR><++><Esc>6ko')
      -- vim.keymap.set('i', '&st','\\vspace{1cm}<CR>\\hfill<CR>\\ding{105}<CR>\\ding{105}<CR>\\ding{105}<CR>\\hfill<CR>\\vspace{1cm}<CR><CR>')
      --vim.keymap.set('i', '&ac','\\autocite[p.~]{<++>}<++><Esc>10hi')
      --vim.keymap.set('i', '&qt','\\begin{quote}<Enter>\\end{quote}<Enter><Enter><++><Esc>3ko')
      --vim.keymap.set('i', '&ev','\\begin{}<Enter><++><Enter>\\end{<++>}<Enter><Enter><++><Esc>4k$i')
    end
}
)

