vim.api.nvim_create_autocmd('FileType',
{
    pattern = 'tex',
    callback = function()
      vim.keymap.set('i', '&li','<Esc>A<Enter>\\item<Space>')
    end
}
)

vim.api.nvim_create_autocmd('FileType',
{
    pattern = 'typst',
    callback = function()
      vim.keymap.set('n', '<Space>ll',':TypstWatch<Enter>')
    end
}
)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end,
})
