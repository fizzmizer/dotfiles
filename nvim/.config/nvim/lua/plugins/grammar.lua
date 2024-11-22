return{

    {
      'ron89/thesaurus_query.vim',
      init = function()
        vim.g.tq_enabled_backends = {'synonymo_fr', 'cnrtl_fr'}
        vim.g.tq_language = 'fr'
      end,
    },

    {
      'dbmrq/vim-ditto',
      init = function()
        vim.g.ditto_min_repetitions = 3
      end,
    },

    {
      'dpelle/vim-Grammalecte',
      init = function()
        vim.g.grammalecte_cli_py ='$HOME/.config/Grammalecte-fr-v2.1.1/grammalecte-cli.py'
      end,
    },
}
