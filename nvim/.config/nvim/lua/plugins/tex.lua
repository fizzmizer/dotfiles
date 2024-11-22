return {
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
}
