local function getWords()
    -- the third string here is the string for visual-block mode (^V)
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
        return vim.fn.wordcount().visual_words .. " words"
    else
        return vim.fn.wordcount().words .. " words"
    end
end

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
