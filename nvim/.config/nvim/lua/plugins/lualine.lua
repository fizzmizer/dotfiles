local function getWords()
    -- the third string here is the string for visual-block mode (^V)
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
        return vim.fn.wordcount().visual_words .. " words"
    else
        return vim.fn.wordcount().words .. " words"
    end
end

return{
    {
       'nvim-lualine/lualine.nvim',
       dependencies = { 'nvim-tree/nvim-web-devicons' },
         config = function()
           require('lualine').setup{
             options = {
	       theme = 'sorciere',
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
}
