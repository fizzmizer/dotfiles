return{
    {
      'vimwiki/vimwiki',
      init = function()
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_listsyms = ' ○◐●✓'
        vim.g.vimwiki_folding = 'expr:quick'
        vim.g.vimwiki_list = {{path= '~/Documents/notes', syntax= 'markdown', ext= '.md', path_html= '~/Documents/notes/html/', custom_wiki2html= 'vimwiki_markdown'}}
      end,
    },
}
