-- stylua: ignore
local colors = {
  black        = '#1C1B19',
  white        = '#FCE8C3',
  red          = '#EF2F27',
  green        = '#519F50',
  blue         = '#2C78BF',
  yellow       = '#FBB829',
  purple       = '#E02C6D',
  darkgray     = '#1A1C23',
  lightgray    = '#2E303E',
  inactivegray = '#1C1E26',
}

return {
  normal = {
    a = { bg = colors.red, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  insert = {
    a = { bg = colors.green, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  replace = {
    a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  command = {
    a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  inactive = {
    a = { bg = colors.inactivegrey, fg = colors.lightgray, gui = 'bold' },
    b = { bg = colors.inactivegray, fg = colors.lightgray },
    c = { bg = colors.inactivegray, fg = colors.lightgray },
  },
}

