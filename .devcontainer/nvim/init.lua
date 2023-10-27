require('options')
require('keymaps')
require('statusline')
require('paren')
require('plugins')

vim.api.nvim_exec([[
let g:sbww_bg_is_none=v:false
colorscheme sbww
]], false)
