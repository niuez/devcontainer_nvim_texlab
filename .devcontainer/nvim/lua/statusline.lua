local fg = "#6F8EB3"
local sky1 = "#bd8840"
local sky2 = "#d06e3e"
local sky3 = "#e9a05a"
local fth1 = "#87bba5"
local fth2 = "#737fc4"
local blue = "#e9a05a"
local grey = "#6A6868"
local white = "#999999"
local none = "NONE"
local bg = "NONE"

function h(group, fg, bg, attr)
  if attr ~= "" then
    vim.api.nvim_exec("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg .. " gui=" .. attr, false)
  else
    vim.api.nvim_exec("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg .. " gui=NONE", false)
  end
end

h("User1", sky1, bg, none)
h("User2", fth1, bg, none)
h("User3", sky1, bg, none)
h("User4", fth2, bg, none)
h("User5", sky2, bg, none)
h("UserStatusLineInner", white, none, none)


vim.api.nvim_exec([[
function! SetStatusLine()
  if mode() =~ 'i'
    let c = 1
    let mode_name = 'INSERT'
  elseif mode() =~ 'n'
    let c = 2
    let mode_name = 'NORMAL'
  elseif mode() =~ 'R'
    let c = 3
    let mode_name = 'REPLACE'
  elseif mode() =~ 'c'
    let c = 4
    let mode_name = 'COMMAND'
  else
    let c = 5
    let mode_name = 'VISUAL'
  endif
  return '%' . c . '*' . mode_name . '%*%#UserStatusLineInner#  %{get(g:,"coc_git_status","")}  %<%F%m%r%= %{&ft}  %c:%l'
endfunction

set statusline=%!SetStatusLine()
]], false)
