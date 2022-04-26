

vim.cmd [[
try
 colorscheme catppuccin
 " colorscheme yowish
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
