return{
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      config = function()
      -- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
      require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/luasnippets/"})

      require("luasnip").config.set_config({
        enable_autosnippets = true,
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

      end
    },
}
