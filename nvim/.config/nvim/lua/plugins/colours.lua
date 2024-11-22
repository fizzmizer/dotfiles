return{
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
      vim.cmd.hi 'Comment gui=none'
    end,
    },

    {'raddari/last-color.nvim'},

}
