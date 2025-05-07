return {
  'kaarmu/typst.vim',
  ft = 'typst',
  lazy=false,
  init = function()
    vim.g.srcery_italic = 1
    vim.g.typst_pdf_viewer = 'okular'
    vim.g.typst_folding = 1
  end,
}
