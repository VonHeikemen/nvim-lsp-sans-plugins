local M = {}

local color =  {
  white   = {gui = '#DCE0DD', cterm = 249},
  black   = {gui = '#2F343F', cterm = 234},
  green   = {gui = '#87D37C', cterm = 108},
  blue    = {gui = '#89C4F4', cterm = 75 },
  cyan    = {gui = '#50C6D8', cterm = 73 },
  red     = {gui = '#FC8680', cterm = 168},
  magenta = {gui = '#DDA0DD', cterm = 139},
  yellow  = {gui = '#F2CA27', cterm = 173},

  bright_black  = {gui = '#5F6672', cterm = 242},
  bright_white  = {gui = '#DADFE1', cterm = 253},

  dark_gray  = {gui = '#939393', cterm = 246},
  gray       = {gui = '#8893A6', cterm = 103},
  light_gray = {gui = '#404750', cterm = 238},
  wild_red   = {gui = '#DF334A', cterm = 167},
  dark_blue  = {gui = '#242830', cterm = 235},
  darkness   = {gui = '#3B4252', cterm = 238},
}

local Theme = {
  globals = {
    type = 'dark',
    foreground = color.white,
    background = color.black,
  },
  syntax = {
    comment  = color.red,
    string   = color.green,
    constant = color.magenta,
    storage  = color.blue,
    special  = color.dark_gray,
    error    = color.wild_red,
    error_bg = nil
  },
  ui = {
    cursorline    = color.dark_blue,
    selection     = color.light_gray,
    colorcolumn   = color.bright_black,
    dark_text     = color.dark_gray,
    line_nr       = color.dark_gray,
    line_bg       = color.darkness,
    folds         = color.dark_gray,
    menu_item     = color.dark_blue,
    menu_selected = color.bright_black,
    search        = color.yellow,
    matchparen    = color.yellow,
    info          = color.cyan,
    warning       = color.yellow,
    error         = color.red
  },
  terminal = {
    white        = color.white.gui,
    bright_white = color.bright_white.gui,
    black        = color.black.gui,
    bright_black = color.bright_black.gui,
    red          = color.red.gui,
    green        = color.green.gui,
    blue         = color.blue.gui,
    magenta      = color.magenta.gui,
    yellow       = color.yellow.gui,
    cyan         = color.cyan.gui,
  }
}

local none = {gui = 'NONE',    cterm = 'NONE'}
local FG   = Theme.globals.foreground
local BG   = Theme.globals.background

local hs = function(group, colors, style)
  local opts = {
    fg = colors.fg.gui,
    bg = colors.bg.gui,
    ctermfg = colors.fg.cterm,
    ctermbg = colors.bg.cterm,
  }

  for _, item in ipairs(style) do
    opts[item] = true
  end

  vim.api.nvim_set_hl(0, group, opts)
end

local hi = function(group, colors)
  vim.api.nvim_set_hl(0, group, {
    fg = colors.fg.gui,
    bg = colors.bg.gui,
    ctermfg = colors.fg.cterm,
    ctermbg = colors.bg.cterm,
  })
end

local link = function(group, link)
  vim.api.nvim_set_hl(0, group, {link = link})
end

M.base_syntax = function(theme)
  local ebg = theme.error_bg or none

  hi('Normal',      {fg = FG,             bg = BG  })
  hi('Comment',     {fg = theme.comment,  bg = none})
  hi('String',      {fg = theme.string,   bg = none})
  hi('Character',   {fg = theme.constant, bg = none})
  hi('Number',      {fg = theme.constant, bg = none})
  hi('Boolean',     {fg = theme.constant, bg = none})
  hi('Float',       {fg = theme.constant, bg = none})
  hi('Function',    {fg = theme.storage,  bg = none})
  hi('Special',     {fg = theme.special,  bg = none})
  hi('SpecialChar', {fg = theme.special,  bg = none})
  hi('SpecialKey',  {fg = theme.special,  bg = none})
  hi('Error',       {fg = theme.error,    bg = ebg })

  hi('Constant',       {fg = none, bg = none})
  hi('Statement',      {fg = none, bg = none})
  hi('Conditional',    {fg = none, bg = none})
  hi('Exception',      {fg = none, bg = none})
  hi('Identifier',     {fg = none, bg = none})
  hi('Type',           {fg = none, bg = none})
  hi('Repeat',         {fg = none, bg = none})
  hi('Label',          {fg = none, bg = none})
  hi('Operator',       {fg = none, bg = none})
  hi('Keyword',        {fg = none, bg = none})
  hi('Delimiter',      {fg = none, bg = none})
  hi('Tag',            {fg = none, bg = none})
  hi('SpecialComment', {fg = none, bg = none})
  hi('Debug',          {fg = none, bg = none})
  hi('PreProc',        {fg = none, bg = none})
  hi('Include',        {fg = none, bg = none})
  hi('Define',         {fg = none, bg = none})
  hi('Macro',          {fg = none, bg = none})
  hi('PreCondit',      {fg = none, bg = none})
  hi('StorageClass',   {fg = none, bg = none})
  hi('Structure',      {fg = none, bg = none})
  hi('Typedef',        {fg = none, bg = none})
  hi('Title',          {fg = none, bg = none})
  hi('Todo',           {fg = none, bg = none})
end

M.ui = function(theme)
  local underline = {'underline'}

  hi('Cursor',       {fg = BG,              bg = FG                 })
  hi('CursorLine',   {fg = none,            bg = theme.cursorline   })
  hi('CursorLineNr', {fg = none,            bg = BG                 })
  hi('ColorColumn',  {fg = none,            bg = theme.colorcolumn  })
  hi('LineNr',       {fg = theme.line_nr,   bg = none               })
  hi('NonText',      {fg = theme.line_nr,   bg = BG                 })
  hi('EndOfBuffer',  {fg = theme.dark_text, bg = BG                 })
  hi('VertSplit',    {fg = theme.line_bg,   bg = BG                 })
  hi('Folded',       {fg = theme.folds,     bg = BG                 })
  hi('FoldColumn',   {fg = theme.folds,     bg = BG                 })
  hi('SignColumn',   {fg = none,            bg = BG                 })
  hi('PMenu',        {fg = none,            bg = theme.menu_item    })
  hi('PMenuSel',     {fg = none,            bg = theme.menu_selected})
  hi('TabLine',      {fg = none,            bg = theme.line_bg      })
  hi('TabLineFill',  {fg = none,            bg = theme.line_bg      })
  hi('TabLineSel',   {fg = none,            bg = BG                 })
  hi('StatusLine',   {fg = none,            bg = theme.line_bg      })
  hi('StatusLineNC', {fg = theme.dark_text, bg = theme.line_bg      })
  hi('WildMenu',     {fg = BG,              bg = theme.search       })
  hi('Visual',       {fg = none,            bg = theme.selection    })
  hi('Search',       {fg = BG,              bg = theme.search       })
  hi('IncSearch',    {fg = BG,              bg = theme.search       })

  hs('MatchParen', {fg = theme.matchparen, bg = none}, underline)

  hi('ErrorMsg',   {fg = theme.error,   bg = none})
  hi('WarningMsg', {fg = theme.warning, bg = none})

  hi('DiagnosticError', {fg = theme.error,   bg = none})
  hi('DiagnosticWarn',  {fg = theme.warning, bg = none})
  hi('DiagnosticInfo',  {fg = theme.info,    bg = none})
  hi('DiagnosticHint',  {fg = FG,            bg = none})

  hs('DiagnosticUnderlineError', {fg = theme.error,   bg = none}, underline)
  hs('DiagnosticUnderlineWarn',  {fg = theme.warning, bg = none}, underline)
  hs('DiagnosticUnderlineInfo',  {fg = theme.info,    bg = none}, underline)
  hs('DiagnosticUnderlineHint',  {fg = FG,            bg = none}, underline)


  hi('NotifyWARNIcon',    {fg = theme.warning, bg = none})
  hi('NotifyWARNBorder',  {fg = theme.warning, bg = none})
  hi('NotifyWARNTitle',   {fg = theme.warning, bg = none})
  hi('NotifyERRORIcon',   {fg = theme.error,   bg = none})
  hi('NotifyERRORBorder', {fg = theme.error,   bg = none})
  hi('NotifyERRORTitle',  {fg = theme.error,   bg = none})
end

M.apply_links = function()
  -- UI: window
  link('FloatBorder', 'Normal')


  -- UI: messages
  link('Question', 'String')


  -- UI: Diagnostic
  link('DiagnosticSignError', 'DiagnosticError')
  link('DiagnosticSignWarn',  'DiagnosticWarn')
  link('DiagnosticSignInfo',  'DiagnosticInfo')
  link('DiagnosticSignHint',  'DiagnosticHint')
  link('DiagnosticFloatingError', 'DiagnosticError')
  link('DiagnosticFloatingWarn',  'DiagnosticWarn')
  link('DiagnosticFloatingInfo',  'DiagnosticInfo')
  link('DiagnosticFloatingHint',  'DiagnosticHint')
  link('DiagnosticVirtualTextError', 'DiagnosticError')
  link('DiagnosticVirtualTextWarn',  'DiagnosticWarn')
  link('DiagnosticVirtualTextInfo',  'DiagnosticInfo')
  link('DiagnosticVirtualTextHint',  'DiagnosticHint')


  -- UI: Netrw
  link('Directory',     'Function')
  link('netrwDir',      'Function')
  link('netrwHelpCmd',  'Special')
  link('netrwMarkFile', 'Search')


  -- Language: HTML
  -- Syntax: built-in
  link('htmlTag',            'Special')
  link('htmlEndTag',         'Special')
  link('htmlTagName',        'Function')
  link('htmlSpecialTagName', 'Function')
  link('htmlArg',            'Normal')


  -- Language: CSS
  -- Syntax: built-in
  link('cssTagName',           'Function')
  link('cssColor',             'Number')
  link('cssVendor',            'Normal')
  link('cssBraces',            'Normal')
  link('cssSelectorOp',        'Normal')
  link('cssSelectorOp2',       'Normal')
  link('cssIdentifier',        'Normal')
  link('cssClassName',         'Normal')
  link('cssClassNameDot',      'Normal')
  link('cssVendor',            'Normal')
  link('cssImportant',         'Normal')
  link('cssAttributeSelector', 'Normal')


  -- Language: PHP
  -- Syntax: built-in
  link('phpNullValue', 'Boolean')
  link('phpParent',    'Normal')
  link('phpClasses',   'Normal')


  -- Language: Javascript
  -- Syntax: built-in
  link('javaScriptNumber',   'Number')
  link('javaScriptNull',     'Number')
  link('javaScriptBraces',   'Normal')
  link('javaScriptFunction', 'Normal')


  -- Python
  link('pythonDecorator',     'Special')
  link('pythonDecoratorName', 'Normal')
  link('pythonBuiltin',       'Normal')
end

M.terminal = function(theme)
  vim.g.terminal_color_foreground = FG.gui
  vim.g.terminal_color_background = BG.gui

  -- black
  vim.g.terminal_color_0  = theme.black
  vim.g.terminal_color_8  = theme.bright_black or theme.black

  -- red
  vim.g.terminal_color_1  = theme.red
  vim.g.terminal_color_9  = theme.bright_red or theme.red

  -- green
  vim.g.terminal_color_2  = theme.green
  vim.g.terminal_color_10 = theme.bright_green or theme.green

  -- yellow
  vim.g.terminal_color_3  = theme.yellow
  vim.g.terminal_color_11 = theme.bright_yellow or theme.yellow

  -- blue
  vim.g.terminal_color_4  = theme.blue
  vim.g.terminal_color_12 = theme.bright_blue or theme.blue

  -- magenta
  vim.g.terminal_color_5  = theme.magenta
  vim.g.terminal_color_13 = theme.bright_magenta or theme.magenta

  -- cyan
  vim.g.terminal_color_6  = theme.cyan
  vim.g.terminal_color_14 = theme.bright_cyan or theme.cyan

  -- white
  vim.g.terminal_color_7  = theme.white
  vim.g.terminal_color_15 = theme.bright_white or theme.white
end

M.init = function(name, args)
  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end

  vim.opt.background = args.type
  vim.g.colors_name = name
end

M.apply = function(name, theme)
  M.init(name, theme.globals)
  M.ui(theme.ui)
  M.base_syntax(theme.syntax)
  M.apply_links()
  M.terminal(theme.terminal)
end

M.apply('darkling', Theme)

